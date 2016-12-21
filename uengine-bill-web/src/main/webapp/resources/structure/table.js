var pullTable = function (table, tableData) {
    var theads = tableData.theads;
    var thead = $('<thead><tr></tr></thead>');
    for (var i = 0; i < theads.length; i++) {
        var width = theads[i].width ? 'width="' + theads[i].width + '"' : '';
        var theadcol = theads[i].colspan ? 'colspan="' + theads[i].colspan + '"' : '';
        thead.find('tr').append('<th ' + width + ' ' + theadcol + ' >' + theads[i].text + '</th>');
    }
    table.append(thead);

    var data = tableData.data;
    var tbody = $('<tbody></tbody>');
    for (var i = 0; i < data.length; i++) {
        var tr = $('<tr></tr>');
        for (var l = 0; l < data[i].length; l++) {
            var td;
            var cell = data[i][l];
            if (typeof cell == 'object') {
                td = $('<td colspan="' + (cell[1]) + '" rowspan="' + (cell[2]) + '">' + cell[0] + '</td>');
                tr.append(td);
            } else {
                if (cell && cell.length > 0) {
                    var nexthasvalue = false;
                    var nextfinished = false;
                    var rowspan = 0;
                    var line = i + 1;
                    while (!nexthasvalue && !nextfinished) {
                        if (typeof data[line] == 'undefined')nextfinished = true;
                        else {
                            if (data[line][l] && data[line][l].length > 0) {
                                nexthasvalue = true;
                            } else {
                                rowspan++;
                                line++;
                            }
                        }
                    }

                    var sidehasvalue = false;
                    var sidefinished = false;
                    var colspan = 0;
                    var step = l + 1;
                    while (!sidehasvalue && !sidefinished) {
                        if (typeof data[i][step] == 'undefined') {
                            sidefinished = true;
                        }
                        else {
                            if (data[i][step] && data[i][step].length > 0) {
                                sidehasvalue = true;
                            } else {
                                colspan++;
                                step++;
                            }
                        }
                    }
                    if (colspan > 0 && rowspan > 0)
                        td = $('<td colspan="' + (colspan + 1) + '" rowspan="' + (rowspan + 1) + '">' + cell + '</td>');
                    else if (colspan > 0)
                        td = $('<td colspan="' + (colspan + 1) + '">' + cell + '</td>');
                    else if (rowspan > 0)
                        td = $('<td rowspan="' + (rowspan + 1) + '">' + cell + '</td>');
                    else {
                        td = $('<td style="vertical-align: middle;">' + cell + '</td>');
                    }
                    tr.append(td);
                }
            }
        }
        tbody.append(tr);
    }
    table.append(tbody);
}