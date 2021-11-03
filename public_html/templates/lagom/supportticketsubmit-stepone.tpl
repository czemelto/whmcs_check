{if isset($RSThemes['pages']['supportticketsubmit-stepone'])}
    {include file=$RSThemes['pages']['supportticketsubmit-stepone']['fullPath']}
{else}
    <div id="supportticketlimitererrorcontainer"></div>
    <p class="desc">{$LANG.supportticketsheader}</p>
    <h3>{$LANG.supportticketschoosedepartment}</h3>
    {if $departments}
        <div class="ticket-departments">
            {foreach from=$departments key=num item=department}
                <a href="{$smarty.server.PHP_SELF}?step=2&amp;deptid={$department.id}">
                    <span class="title">
                        {$department.name} 
                        
                        {* 
                            -- Start of integration code --
                            - Integration code for: Premium Support Tickets For WHMCS from ModulesGarden
                            - Module URL: https://www.modulesgarden.com/products/whmcs/premium-support-tickets
                        *}
                       
                        {if $PremiumSupportTickets.$num}  
                        {if $PremiumSupportTickets.$num.canCreate}
                            <span class="label label-success">{$PremiumSupportTickets.$num.message}</span>
                        {else}
                        <span class="label label-danger">{$PremiumSupportTickets.$num.message}</span>
                        {/if}
                        {/if}
                        {* -- End of integration code -- *}
                    </span>
                    {if $department.description}
                        <p>{$department.description}</p>
                    {/if}
                    {*
                        -- Start of integration code --
                        - Integration code for: Premium Support Tickets For WHMCS from ModulesGarden
                        - Module URL: https://www.modulesgarden.com/products/whmcs/premium-support-tickets
                    *}
                    {if $PremiumSupportTickets.$num}                      
                        {if $PremiumSupportTickets.$num.canCreate}
                            <p>
                                {$PremiumSupportTickets.$num.havePointsMsg} {$PremiumSupportTickets.$num.havePoints}
                            </p>
                        {else}
                            <p>
                                {$PremiumSupportTickets.$num.requiredPointsMsg} {$PremiumSupportTickets.$num.requiredPoints} <br />
                                {$PremiumSupportTickets.$num.havePointsMsg} {$PremiumSupportTickets.$num.havePoints} <br />
                            </p>
                        {/if}
                    {/if}
                    {* -- End of integration code -- *}
                </a>    
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
{/if}    
