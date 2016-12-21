package org.uengine.garuda.web.tags;


import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceResolvable;
import org.springframework.context.NoSuchMessageException;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.tags.ArgumentAware;
import org.springframework.web.servlet.tags.HtmlEscapingAwareTag;
import org.springframework.web.util.JavaScriptUtils;
import org.springframework.web.util.TagUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import java.io.IOException;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

/**
 * Custom JSP tag to look up a message in the scope of this page. Messages are
 * resolved using the ApplicationContext and thus support internationalization.
 * <p/>
 * <p>Detects an HTML escaping setting, either on this tag instance, the page level,
 * or the {@code web.xml} level. Can also apply JavaScript escaping.
 * <p/>
 * <p>If "code" isn't set or cannot be resolved, "text" will be used as default
 * message. Thus, this tag can also be used for HTML escaping of any texts.
 * <p/>
 * <p>Message arguments can be specified via the {@link #setArguments(Object) arguments}
 * attribute or by using nested {@code <spring:argument>} tags.
 *
 * @author Rod Johnson
 * @author Juergen Hoeller
 * @author Nicholas Williams
 * @see #setCode
 * @see #setText
 * @see #setHtmlEscape
 * @see #setJavaScriptEscape
 * @see org.springframework.web.servlet.tags.HtmlEscapeTag#setDefaultHtmlEscape
 * @see org.springframework.web.util.WebUtils#HTML_ESCAPE_CONTEXT_PARAM
 * @see org.springframework.web.servlet.tags.ArgumentTag
 */
public class MessageTag extends HtmlEscapingAwareTag implements ArgumentAware {

    /**
     * Default separator for splitting an arguments String: a comma (",")
     */
    public static final String DEFAULT_ARGUMENT_SEPARATOR = ",";


    private MessageSourceResolvable message;

    private String code;

    private Object arguments;

    private String argumentSeparator = DEFAULT_ARGUMENT_SEPARATOR;

    private List<Object> nestedArguments;

    private String text;

    private String var;

    private String scope = TagUtils.SCOPE_PAGE;

    private boolean javaScriptEscape = false;


    /**
     * Set the MessageSourceResolvable for this tag.
     * <p>If a MessageSourceResolvable is specified, it effectively overrides
     * any code, arguments or text specified on this tag.
     */
    public void setMessage(MessageSourceResolvable message) {
        this.message = message;
    }

    /**
     * Set the message code for this tag.
     */
    public void setCode(String code) {
        this.code = code;
    }

    /**
     * Set optional message arguments for this tag, as a comma-delimited
     * String (each String argument can contain JSP EL), an Object array
     * (used as argument array), or a single Object (used as single argument).
     */
    public void setArguments(Object arguments) {
        this.arguments = arguments;
    }

    /**
     * Set the separator to use for splitting an arguments String.
     * Default is a comma (",").
     *
     * @see #setArguments
     */
    public void setArgumentSeparator(String argumentSeparator) {
        this.argumentSeparator = argumentSeparator;
    }

    @Override
    public void addArgument(Object argument) throws JspTagException {
        this.nestedArguments.add(argument);
    }

    /**
     * Set the message text for this tag.
     */
    public void setText(String text) {
        this.text = text;
    }

    /**
     * Set PageContext attribute name under which to expose
     * a variable that contains the resolved message.
     *
     * @see #setScope
     * @see javax.servlet.jsp.PageContext#setAttribute
     */
    public void setVar(String var) {
        this.var = var;
    }

    /**
     * Set the scope to export the variable to.
     * Default is SCOPE_PAGE ("page").
     *
     * @see #setVar
     * @see TagUtils#SCOPE_PAGE
     * @see javax.servlet.jsp.PageContext#setAttribute
     */
    public void setScope(String scope) {
        this.scope = scope;
    }

    /**
     * Set JavaScript escaping for this tag, as boolean value.
     * Default is "false".
     */
    public void setJavaScriptEscape(boolean javaScriptEscape) throws JspException {
        this.javaScriptEscape = javaScriptEscape;
    }


    @Override
    protected final int doStartTagInternal() throws JspException, IOException {
        this.nestedArguments = new LinkedList<Object>();
        return EVAL_BODY_INCLUDE;
    }

    /**
     * Resolves the message, escapes it if demanded,
     * and writes it to the page (or exposes it as variable).
     *
     * @see #resolveMessage()
     * @see org.springframework.web.util.HtmlUtils#htmlEscape(String)
     * @see JavaScriptUtils#javaScriptEscape(String)
     * @see #writeMessage(String)
     */
    @Override
    public int doEndTag() throws JspException {
        try {
            // Resolve the unescaped message.
            String msg = resolveMessage();

            // HTML and/or JavaScript escape, if demanded.
            msg = htmlEscape(msg);
            msg = this.javaScriptEscape ? JavaScriptUtils.javaScriptEscape(msg) : msg;

            // Expose as variable, if demanded, else write to the page.
            if (this.var != null) {
                pageContext.setAttribute(this.var, msg, TagUtils.getScope(this.scope));
            } else {
                writeMessage(msg);
            }

            return EVAL_PAGE;
        } catch (IOException ex) {
            throw new JspTagException(ex.getMessage(), ex);
        } catch (NoSuchMessageException ex) {
            throw new JspTagException(getNoSuchMessageExceptionDescription(ex));
        }
    }

    @Override
    public void release() {
        super.release();
        this.arguments = null;
    }

    /**
     * Resolve the specified message into a concrete message String.
     * The returned message String should be unescaped.
     */
    protected String resolveMessage() throws JspException, NoSuchMessageException {
        MessageSource messageSource = getMessageSource();
        if (messageSource == null) {
            throw new JspTagException("No corresponding MessageSource found");
        }

        // Evaluate the specified MessageSourceResolvable, if any.
        if (this.message != null) {
            // We have a given MessageSourceResolvable.
            return messageSource.getMessage(this.message, getRequestContext().getLocale());
        }

        if (this.code != null || this.text != null) {
            // We have a code or default text that we need to resolve.
            Object[] argumentsArray = resolveArguments(this.arguments);
            if (!this.nestedArguments.isEmpty()) {
                argumentsArray = appendArguments(argumentsArray,
                        this.nestedArguments.toArray());
            }

            if (this.text != null) {
                // We have a fallback text to consider.
                return messageSource.getMessage(
                        this.code, argumentsArray, this.text, getRequestContext().getLocale());
            } else {
                // We have no fallback text to consider.
                return messageSource.getMessage(
                        this.code, argumentsArray, getRequestContext().getLocale());
            }
        }

        // All we have is a specified literal text.
        return this.text;
    }

    private Object[] appendArguments(Object[] sourceArguments, Object[] additionalArguments) {
        if (ObjectUtils.isEmpty(sourceArguments)) {
            return additionalArguments;
        }
        Object[] arguments = new Object[sourceArguments.length + additionalArguments.length];
        System.arraycopy(sourceArguments, 0, arguments, 0, sourceArguments.length);
        System.arraycopy(additionalArguments, 0, arguments, sourceArguments.length, additionalArguments.length);
        return arguments;
    }

    /**
     * Resolve the given arguments Object into an arguments array.
     *
     * @param arguments the specified arguments Object
     * @return the resolved arguments as array
     * @throws JspException if argument conversion failed
     * @see #setArguments
     */
    protected Object[] resolveArguments(Object arguments) throws JspException {
        if (arguments instanceof String) {
            String[] stringArray =
                    StringUtils.delimitedListToStringArray((String) arguments, this.argumentSeparator);
            if (stringArray.length == 1) {
                Object argument = stringArray[0];
                if (argument != null && argument.getClass().isArray()) {
                    return ObjectUtils.toObjectArray(argument);
                } else {
                    return new Object[]{argument};
                }
            } else {
                return stringArray;
            }
        } else if (arguments instanceof Object[]) {
            return (Object[]) arguments;
        } else if (arguments instanceof Collection) {
            return ((Collection<?>) arguments).toArray();
        } else if (arguments != null) {
            // Assume a single argument object.
            return new Object[]{arguments};
        } else {
            return null;
        }
    }

    /**
     * Write the message to the page.
     * <p>Can be overridden in subclasses, e.g. for testing purposes.
     *
     * @param msg the message to write
     * @throws IOException if writing failed
     */
    protected void writeMessage(String msg) throws IOException {
        pageContext.getOut().write(String.valueOf(msg));
    }

    /**
     * Use the current RequestContext's application context as MessageSource.
     */
    protected MessageSource getMessageSource() {
        return getRequestContext().getMessageSource();
    }

    /**
     * Return default exception message.
     */
    protected String getNoSuchMessageExceptionDescription(NoSuchMessageException ex) {
        return ex.getMessage();
    }

}
