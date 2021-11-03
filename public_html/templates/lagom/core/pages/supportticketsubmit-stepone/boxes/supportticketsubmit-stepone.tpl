<p class="desc">{$LANG.supportticketsheader}</p>
<h3>{$LANG.supportticketschoosedepartment}</h3>
{if $departments}
    <div class="row row-eq-height ticket-departments-boxes">
        {foreach from=$departments key=num item=department}
            <div class="col-sm-4">
                <a href="{$smarty.server.PHP_SELF}?step=2&amp;deptid={$department.id}" class="panel panel-default panel-support">
                    <div class="panel-body">
                        <h4 class="title">{$department.name}</h4>
                        {if $department.description}
                            <p class="m-b-0">{$department.description}</p>
                        {/if}
                    </div> 
                    {* 
                        -- Start of integration code --
                        - Integration code for: Premium Support Tickets For WHMCS from ModulesGarden
                        - Module URL: https://www.modulesgarden.com/products/whmcs/premium-support-tickets
                    *}
                    {if $PremiumSupportTickets.$num}
                    <div class="panel-footer">                       
                    {if $PremiumSupportTickets.$num.canCreate}
                        <span class="label label-success">{$PremiumSupportTickets.$num.message}</span>
                        <p>
                            {$PremiumSupportTickets.$num.havePointsMsg} {$PremiumSupportTickets.$num.havePoints}
                        </p>
                    {else}
                        <span class="label label-danger">{$PremiumSupportTickets.$num.message}</span>
                        <p>
                            {$PremiumSupportTickets.$num.requiredPointsMsg} {$PremiumSupportTickets.$num.requiredPoints} <br />
                            {$PremiumSupportTickets.$num.havePointsMsg} {$PremiumSupportTickets.$num.havePoints} <br />
                        </p>
                    {/if}
                    </div>
                    {/if}
                    {* -- End of integration code -- *}
                </a>    
            </div>
        {/foreach}
    </div>
{else}
    <div class="message message-no-data">
        <div class="message-image">
            {include file="$template//assets/svg-icon/ticket.tpl"}        
        </div>
        <h6 class="message-text">{$LANG.nosupportdepartments}</h6>
    </div>
{/if}