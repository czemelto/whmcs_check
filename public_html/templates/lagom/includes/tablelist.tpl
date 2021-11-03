{if file_exists("templates/$template/includes/overwrites/tablelist.tpl")}
    {include file="{$template}/includes/overwrites/tablelist.tpl"}  
{else}
    <link rel="stylesheet" type="text/css" href="{$BASE_PATH_CSS}/dataTables.responsive.css">
    <script type="text/javascript" charset="utf8" src="{$BASE_PATH_JS}/jquery.dataTables.min.js"></script>
    <script type="text/javascript" charset="utf8" src="{$BASE_PATH_JS}/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript" charset="utf8" src="{$BASE_PATH_JS}/dataTables.responsive.min.js"></script>

    {if isset($filterColumn) && $filterColumn}
    <script type="text/javascript">
        if (typeof(buildFilterRegex) !== "function") {
            function buildFilterRegex(filterValue) {
                if (filterValue.indexOf('&') === -1) {
                    return '[~>]\\s*' + jQuery.fn.dataTable.util.escapeRegex(filterValue) + '\\s*[<~]';
                } else {
                    var tempDiv = document.createElement('div');
                    tempDiv.innerHTML = filterValue;
                    return '\\s*' + jQuery.fn.dataTable.util.escapeRegex(tempDiv.innerText) + '\\s*';
                }
            }
        }
        jQuery(document).ready(function () {ldelim}
            jQuery(".view-filter-btns .dropdown-menu a").click(function(e) {ldelim}
                var filterValue = jQuery(this).find("span").data('value');
                var filterText = jQuery(this).find("span").html().trim();
                var dataTable = jQuery('#table{$tableName}').DataTable();
                var filterValueRegex;
                $(this).closest('.dropdown-menu').find('.active').removeClass('active');
                $(this).parent().addClass('active');
                $(this).closest('.view-filter-btns').find('.dropdown-toggle span').text(filterText);
                if (filterValue == "all") {ldelim}
                    dataTable.column({$filterColumn}).search('').draw();
                    {rdelim} else {ldelim}
                    filterValueRegex = buildFilterRegex(filterValue);
                    dataTable.column({$filterColumn})
                        .search(filterValueRegex, true, false, false)
                        .draw();
                {rdelim}
                // Prevent jumping to the top of the page
                // when no matching tag is found.
                e.preventDefault();
            {rdelim});
        {rdelim});
    </script>
    {/if}

    <script type="text/javascript">

        function checkAll(){
            let checkAll = $('#selectAll');
            let checkboxes = $('.domids').not(':disabled');
            checkAll.on('ifChecked ifUnchecked', function(e) {
                if (e.type == 'ifChecked') {
                    checkboxes.iCheck('check');
                } else {
                    checkboxes.iCheck('uncheck');
                }
            });
            checkboxes.on('ifChanged', function(e){
                if(checkboxes.filter(':checked').length > 0){
                    $('#domainSelectedCounter').addClass('badge--primary');
                    $('.bottom-action-sticky').css('opacity' , '1');
                    $('body').addClass('is-actions');
                }
                else{
                    $('#domainSelectedCounter').removeClass('badge--primary');
                    $('.bottom-action-sticky').css('opacity' , '0');
                    $('body').removeClass('is-actions');
                }
                $('#domainSelectedCounter').text(checkboxes.filter(':checked').length);
                if(checkboxes.filter(':checked').length == checkboxes.length) {
                    checkAll.prop('checked', 'checked');
                } else {
                    checkAll.removeProp('checked');
                }
                checkAll.iCheck('update');
            });
        };

        var alreadyReady = false; // The ready function is being called twice on page load.
        jQuery(document).ready( function () {ldelim}

            var table = jQuery("#table{$tableName}").DataTable({ldelim}
                "dom": '<"listtable"fit>pl',{if isset($noPagination) && $noPagination}
                "paging": false,{/if}
                "info": false,{if isset($noSearch) && $noSearch}
                "filter": false,{/if}
                "responsive": true,
                "oLanguage": {ldelim}
                    "sEmptyTable":     "{$LANG.norecordsfound}",
                    "sInfo":           "{$LANG.tableshowing}",
                    "sInfoEmpty":      "{$LANG.tableempty}",
                    "sInfoFiltered":   "{$LANG.tablefiltered}",
                    "sInfoPostFix":    "",
                    "sInfoThousands":  ",",
                    "sLengthMenu":     "{$LANG.tablelength}",
                    "sLoadingRecords": "{$LANG.tableloading}",
                    "sProcessing":     "{$LANG.tableprocessing}",
                    "sSearch":         "",
                    "sZeroRecords":    "{$LANG.norecordsfound}",
                    "oPaginate": {ldelim}
                        "sFirst":    "{$LANG.tablepagesfirst}",
                        "sLast":     "{$LANG.tablepageslast}",
                        "sNext":     "{$LANG.tablepagesnext}",
                        "sPrevious": "{$LANG.tablepagesprevious}"
                    {rdelim}
                {rdelim},
                "pageLength": 10,
                "order": [
                    [ {if isset($startOrderCol) && $startOrderCol}{$startOrderCol}{else}0{/if}, "asc" ]
                ],
                "lengthMenu": [
                    [10, 25, 50, -1],
                    [10, 25, 50, "{$LANG.tableviewall}"]
                ],
                "aoColumnDefs": [
                    {ldelim}
                        "bSortable": false,
                        "aTargets": [ {if isset($noSortColumns) && $noSortColumns !== ''}{$noSortColumns}{/if} ]
                    {rdelim},
                    {ldelim}
                        "sType": "string",
                        "aTargets": [ {if isset($filterColumn) && $filterColumn}{$filterColumn}{/if} ]
                    {rdelim}
                ],
                "stateSave": true,
                "autoWidth": false,
            {rdelim});
                
            {if isset($filterColumn) && $filterColumn}
            // highlight remembered filter on page re-load
            var rememberedFilterTerm = table.state().columns[{$filterColumn}].search.search;
            if (rememberedFilterTerm && !alreadyReady) {
            
                // This should only run on the first "ready" event.
                jQuery(".view-filter-btns a span").each(function(index) {
                    if (buildFilterRegex(jQuery(this).text().trim()) == rememberedFilterTerm) {
                        $(this).closest('li').addClass('active');
                        $(this).closest('.view-filter-btns').find('.dropdown-toggle span').text(jQuery(this).text());
                    }
                });
            }
            {/if}
        alreadyReady = true;
             if ($('#table-search').length > 0 && $('.dataTables_filter').length > 0){
                var searchTableVal = $('.dataTables_filter input').val();
                $('#table-search').val(searchTableVal);
                var searchVal = $('#table-search').val();
                table.search(searchVal, true).draw();
            }

            $('#table-search').on('keyup', function () {
                table.search(this.value, true).draw();
            });
            table.on('draw.dt', function () {
                $('body').find('input:not(.icheck-input):not(.switch__checkbox)').iCheck({
                    checkboxClass: 'checkbox-styled',
                    radioClass: 'radio-styled',
                    increaseArea: '40%'
                });
                checkAll();

            });

        
        {rdelim});

    </script>
{/if}