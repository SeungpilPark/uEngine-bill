structure.init = function () {
    var data = this.data.menu;
    for (var i = 0; i < data.length; i++) {
        this.buildMenu(data[i], $("#menu_definition"), 0);
    }
}

/*
 메뉴 빌드
 */
structure.buildMenu = function (menu, parent, depth) {

    var li = $('<li></li>');
    var _a = $('<a></a>');

    if (menu['menu']) {
        if (depth != 0) {
            li.addClass('dropdown-submenu');
        } else {
            li.addClass('dropdown');
        }
    }
    if (menu['wide']){
        li.addClass('mega-menu-fullwidth');
    }

    if (menu['menu'] && depth == 0) {
        _a.addClass('dropdown-toggle');
        _a.attr('data-toggle', 'dropdown');
    }

    if (menu['awesome']) {
        _a.html('<i class="' + menu['awesome'] + '"></i>' + menu['title']);
    } else {
        _a.html(menu['title']);
    }

    if (menu['href']) {
        _a.attr('href', menu['href']);
        if(menu['target']){
            _a.attr('target', menu['target']);
        }
    } else {
        _a.attr('href', "javascript:void(0);");
    }
    li.append(_a);

    var newDepth = depth + 1;

    if (menu['menu'] && menu['wide']) {
        var baseStr = '' +
            '<ul class="dropdown-menu">' +
            '<li>' +
            '<div class="mega-menu-content disable-icons">' +
            '<div class="container">' +
            '<div class="row equal-height" name="menu_wide_base">' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</li>' +
            '</ul>';
        var _base = $(baseStr);
        li.append(_base);
        for (var i = 0; i < menu['menu'].length; i++) {
            var _div = $('<div class="col-md-3 equal-height-in"></div>');
            var _ul = $('<ul class="list-unstyled equal-height-list"></ul>');
            _div.append(_ul);
            _base.find('[name=menu_wide_base]').append(_div);

            var _header = menu['menu'][i];
            _ul.append('<li><h3>'+_header['title']+'</h3></li>');
            if(_header['menu']){
                for(var h=0; h <_header['menu'].length;h++){
                    structure.buildMenu(_header['menu'][h], _ul, newDepth);
                }
            }
        }
        //와이드 메뉴의 카테고리에 따라 넓이 배분
        if ( menu['menu'].length < 4){
            var percent = ((100 / 4) * ( 4 - menu['menu'].length) / 2) + "%";
            _base.css('left' , percent);
            _base.css('right' , percent);
        }

    } else if
    (menu['menu']) {
        var _ul = $('<ul class="dropdown-menu"></ul>');
        li.append(_ul);
        for (var i = 0; i < menu['menu'].length; i++) {
            structure.buildMenu(menu['menu'][i], _ul, newDepth);
        }
    }

    parent.append(li);
}


structure.init();