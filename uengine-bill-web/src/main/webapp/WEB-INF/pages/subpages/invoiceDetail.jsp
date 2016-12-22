<div class="ibox float-e-margins">
    <div class="ibox-title">
        <span><span style="font-size: 18px">CN-00010</span> <a class="btn btn-default btn-sm" name="goBack"><i
                class="fa fa-arrow-left"></i></a></span>

        <div class="ibox-tools">
            <button type="button" class="btn btn-default btn-sm" name="print-btn" data-target-id="invoice-details-info">
                <i class="fa fa-print"></i></button>
            <button type="button" class="btn btn-default btn-sm" name="pdf-btn"><i class="fa fa-file-pdf-o"></i>
            </button>
            <button type="button" class="btn btn-default btn-sm" name="email-btn" data-target-id="invoice-email-modal">
                <i class="fa fa-envelope-o"></i></button>

            <button type="button" class="dropdown-toggle btn btn-default btn-sm" data-toggle="dropdown"
                    href="#">MORE
            </button>
            <ul class="dropdown-menu dropdown-user">
                <li><a href="#">Update Custom Fields</a>
                </li>
                <li><a href="#">Update Billing Address</a>
                </li>
                <li><a href="#">Update Shipping Address</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="ibox-content">

        <div class="details-page" style="margin-top:0">
            <div class="details-info" id="invoice-details-info">

                <span class="label label-success">Paid</span>

                <!--style_start-->
                <style type="text/css" media="all">


                    .pcs-template {
                        font-family: Open Sans;
                        font-size: 9pt;
                        color: #333333;
                        background: #ffffff;
                    }

                    .pcs-header-content {
                        font-size: 9pt;
                        color: #333333;
                        background-color: #ffffff;
                    }

                    .pcs-template-body {
                        padding: 0 0.400000in 0 0.550000in;
                    }

                    .pcs-template-footer {
                        height: 0.700000in;
                        font-size: 6pt;
                        color: #aaaaaa;
                        padding: 0 0.400000in 0 0.550000in;
                        background-color: #ffffff;
                    }

                    .pcs-footer-content {
                        word-wrap: break-word;
                        color: #aaaaaa;
                        border-top: 1px solid #e3e3e3;
                    }

                    .pcs-label {
                        color: #817d7d;
                    }

                    .pcs-entity-title {
                        font-size: 28pt;
                        color: #000000;
                    }

                    .pcs-orgname {
                        font-size: 10pt;
                        color: #333333;
                    }

                    .pcs-customer-name {
                        font-size: 9pt;
                        color: #333333;
                    }

                    .pcs-itemtable-header {
                        font-size: 9pt;
                        color: #ffffff;
                        background-color: #3c3d3a;
                    }

                    .pcs-taxtable-header {
                        font-size: 9pt;
                        color: #000;
                        background-color: #f5f4f3;
                    }

                    .itemBody tr {
                        page-break-inside: avoid;
                        page-break-after: auto;
                    }

                    .pcs-item-row {
                        font-size: 8pt;
                        border-bottom: 1px solid #e3e3e3;
                        background-color: #ffffff;
                        color: #000000;
                    }

                    .pcs-item-sku {
                        margin-top: 2px;
                        font-size: 10px;
                        color: #545454;
                    }

                    .pcs-item-desc {
                        color: #727272;
                        font-size: 8pt;
                    }

                    .pcs-balance {
                        background-color: #f5f4f3;
                        font-size: 9pt;
                        color: #000000;
                    }

                    .pcs-totals {
                        font-size: 9pt;
                        color: #000000;
                        background-color: #ffffff;
                    }

                    .pcs-notes {
                        font-size: 8pt;
                    }

                    .pcs-terms {
                        font-size: 8pt;
                    }

                    .pcs-header-first {
                        background-color: #ffffff;
                        font-size: 9pt;
                        color: #333333;
                        height: auto;
                    }

                    .pcs-status {
                        color: inherit;
                        font-size: 15pt;
                        border: 3px solid;
                        padding: 3px 8px;
                    }

                    @page :first {
                        @top-center {
                            content: element(header);
                        }
                        margin-top: 0.700000in;
                    }

                    .pcs-template-header {
                        padding: 0 0.400000in 0 0.550000in;
                        height: 0.700000in;
                    }

                </style>

                <!--style_end-->

                <div class="pcs-template">
                    <div id="header" class="pcs-template-header pcs-header-content">


                    </div>

                    <div class="pcs-template-body">
                        <table style="width:100%;table-layout: fixed;">
                            <tbody>
                            <tr>
                                <td style="vertical-align: top; width:50%;">
                                    <div>
                                    </div>
                                    <span class="pcs-orgname"><b>LecleTest</b></span><br>
             <span class="pcs-label">
             <span id="tmp_org_address" style="white-space: pre-wrap;word-wrap: break-word;">South Korea</span>
             </span>
                                </td>
                                <td style="vertical-align: top; text-align:right;width:50%;">
                                    <span class="pcs-entity-title">INVOICE</span><br>
                                    <span class="pcs-label" style="font-size: 10pt;" id="tmp_entity_number"><b>#
                                        INV-000041</b></span>

                                    <div style="clear:both;margin-top:20px;">
                                        <span style="font-size:8pt;"><b>Balance Due</b></span><br>
                                        <span style="font-size:12pt;"><b>$0.00</b></span>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <table style="clear:both;width:100%;margin-top:30px;table-layout:fixed;">
                            <tbody>
                            <tr>
                                <td style="width:60%;vertical-align:bottom;word-wrap: break-word;">
                                    <div><label id="tmp_billing_address_label" class="pcs-label"
                                                style="font-size: 10pt;">Bill To</label>
                                        <br>
                                        <span id="zb-pdf-customer-detail" class="pcs-customer-name"><a
                                                href="#/customers/188677000000108039">unionnec2 </a></span><br>
            <span id="tmp_billing_address" style="white-space: pre-wrap;">inovally C dong
sungnam
000-000 AL
South Korea</span>
                                    </div>
                                </td>
                                <td style="vertical-align:bottom;width: 40%;" align="right">
                                    <table cellpadding="0" cellspacing="0" border="0"
                                           style="float:right;width: 100%;table-layout: fixed;word-wrap: break-word;">
                                        <tbody>
                                        <tr>
                                            <td style="text-align:right;padding:5px 10px 5px 0px;font-size:10pt;">
                                                <span class="pcs-label">Invoice Date :</span>
                                            </td>
                                            <td style="text-align:right;">
                                                <span id="tmp_entity_date">20 Dec 2016</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right;padding:5px 10px 5px 0px;font-size: 10pt;">
                                                <span class="pcs-label">Terms :</span>
                                            </td>
                                            <td style="text-align:right;">
                                                <span id="tmp_payment_terms">Due On Receipt</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right;padding:5px 10px 5px 0px;font-size: 10pt;">
                                                <span class="pcs-label">Due Date :</span>
                                            </td>
                                            <td style="text-align:right;">
                                                <span id="tmp_due_date">20 Dec 2016</span>
                                            </td>
                                        </tr>

                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <table cellpadding="0" cellspacing="0" border="0" class="pcs-itemtable"
                               style="width:100%;margin-top:20px;table-layout:fixed;">
                            <thead>
                            <tr style="height:32px;">
                                <td class="pcs-itemtable-header"
                                    style="padding:5px 0 5px 5px;text-align: center;word-wrap: break-word;width: 5%;">
                                    #
                                </td>
                                <td class="pcs-itemtable-header pcs-itemtable-description"
                                    style="padding:5px 10px 5px 20px;word-wrap: break-word;">
                                    Item &amp; Description
                                </td>
                                <td class="pcs-itemtable-header"
                                    style="padding:5px 10px 5px 5px;word-wrap: break-word;width: 11%;" align="right">
                                    Qty
                                </td>
                                <td class="pcs-itemtable-header"
                                    style="padding:5px 10px 5px 5px;word-wrap: break-word;width: 11%;" align="right">
                                    Rate
                                </td>
                                <td class="pcs-itemtable-header"
                                    style="padding:5px 10px 5px 5px;word-wrap: break-word;width: 11%;" align="right">
                                    Discount
                                </td>
                                <td class="pcs-itemtable-header"
                                    style="padding:5px 10px 5px 5px;word-wrap: break-word;width:120px;" align="right">
                                    Amount
                                </td>
                            </tr>
                            </thead>
                            <tbody class="itemBody">
                            <tr>
                                <td class="pcs-item-row"
                                    style="padding: 10px 0 10px 5px;text-align: center;word-wrap: break-word;"
                                    valign="top">
                                    1
                                </td>

                                <td class="pcs-item-row" style="padding: 10px 0px 10px 20px;" valign="top">
                                    <div>
                                        <div>
                                            <span id="tmp_item_name" style="word-wrap: break-word;">storage-usage</span><br>

                                            <span id="tmp_item_description" class="pcs-item-desc"
                                                  style="white-space: pre-wrap;word-wrap: break-word;"></span>

                                        </div>
                                    </div>
                                </td>
                                <td class="pcs-item-row"
                                    style="padding: 10px 10px 5px 10px;text-align:right;word-wrap: break-word;"
                                    valign="top">
                                    <span id="tmp_item_qty">800</span>
                                </td>
                                <td class="pcs-item-row"
                                    style="padding: 10px 10px 5px 10px;text-align:right;word-wrap: break-word;"
                                    valign="top">
                                    <span id="tmp_item_rate">160.00</span>
                                </td>
                                <td id="tmp_item_discount" class="pcs-item-row"
                                    style="padding: 10px 10px 5px 10px;text-align:right;word-wrap: break-word;"
                                    valign="top">
                                    30%
                                </td>
                                <td class="pcs-item-row"
                                    style="text-align:right;padding: 10px 10px 10px 5px;word-wrap: break-word;"
                                    valign="top">
                                    <span id="tmp_item_amount">112.00</span>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <div style="width: 100%;margin-top: 1px;">
                            <div style="width: 45%;padding: 10px 10px 3px 3px;font-size: 9pt;float: left;">
                                <div style="white-space: pre-wrap;"></div>
                            </div>
                            <div style="width: 50%;float:right;">
                                <table width="100%" border="0" cellspacing="0" class="pcs-totals">
                                    <tbody>
                                    <tr>
                                        <td style="padding: 5px 10px 5px 0;" align="right" valign="middle">Sub Total
                                        </td>
                                        <td style="width:120px;padding: 10px 10px 10px 5px;" align="right"
                                            valign="middle" id="tmp_subtotal">112.00
                                        </td>
                                    </tr>

                                    <tr style="height:10px;">
                                        <td style="padding: 5px 10px 5px 0;" align="right" valign="middle">US TAX (5%)
                                        </td>
                                        <td style="width:120px;padding: 10px 10px 10px 5px;" align="right"
                                            valign="middle">5.60
                                        </td>
                                    </tr>


                                    <tr>
                                        <td style="padding: 5px 10px 5px 0;" align="right" valign="middle"><b>Total</b>
                                        </td>
                                        <td style="width:120px;padding: 10px 10px 10px 5px;" align="right"
                                            valign="middle" id="tmp_total"><b>$117.60</b></td>
                                    </tr>


                                    <tr style="height:10px;">
                                        <td style="padding: 5px 10px 5px 0;" align="right" valign="middle">Credits
                                            Applied
                                        </td>
                                        <td style="color: red;width:120px;padding: 10px 10px 10px 5px;" align="right"
                                            valign="middle">(-) 117.60
                                        </td>
                                    </tr>

                                    <tr class="pcs-balance" style="height:40px;">
                                        <td style="padding:5px 10px 5px 0;" valign="middle" align="right"><b>Balance
                                            Due</b></td>
                                        <td style="width:120px;padding: 10px 10px 10px 5px;" valign="middle"
                                            align="right" id="tmp_balance_due"><b>$0.00</b></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div style="clear: both;"></div>
                        </div>


                        <div style="clear:both;margin-top:50px;width:100%;">
                            <label class="pcs-label" id="tmp_notes_label" style="font-size: 10pt;">Notes</label><br>

                            <p class="pcs-notes" style="margin-top:7px;white-space: pre-wrap;word-wrap: break-word;">
                                Thanks for your business.</p>
                        </div>


                    </div>

                    <div class="pcs-template-footer">
                        <div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>