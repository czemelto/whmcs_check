{if isset($RSThemes.pages.clientareacreditcard)}
    {include file=$RSThemes['pages']['clientareacreditcard']['fullPath']}
{else}
    {if $remoteupdatecode}
        <div align="center">
            {$remoteupdatecode}
        </div>
    {else}
        {if $successful}
            {include file="$template/includes/alert.tpl" type="success" additionalClasses="m-w-448" msg=$LANG.changessavedsuccessfully}
        {/if}
        {if $errormessage}
            {include file="$template/includes/alert.tpl" type="error" additionalClasses="m-w-448" errorshtml=$errormessage}
        {/if}
        {if $cardlastfour}
        <div class="credit-card">
            <div class="credit-card-container">
                {* <div class="card-icon pull-right">
                    {if $cardtype eq "American Express"}
                        <img src="templates/{$template}/assets/img/creditcards/visa.png" alt="credit card"/>   
                    {elseif $cardtype eq "Visa"}
                        <img src="templates/{$template}/assets/img/creditcards/visa.png" alt="credit card"/>   
                    {elseif $cardtype eq "MasterCard"}
                    <img src="templates/{$template}/assets/img/creditcards/visa.png" alt="credit card"/>   
                    {elseif $cardtype eq "Discover"}
                        <img src="templates/{$template}/assets/img/creditcards/visa.png" alt="credit card"/>   
                    {else}
                        <img src="templates/{$template}/assets/img/creditcards/visa.png" alt="credit card"/>   
                    {/if}
                </div> *}
                {* <div class="card-type">
                    {if $cardtype neq "American Express" && $cardtype neq "Visa" && $cardtype neq "MasterCard" && $cardtype neq "Discover"}
                        {$cardtype}
                    {/if}
                </div> *}
                <div class="card-number m-t-24">
                    <span>• • • •</span>
                    <span>• • • •</span>
                    <span>• • • •</span>
                    <span>{$cardlastfour}</span>
                </div>
                <div class="card-dates">
                    <div class="card-start">
                        {if $cardstart}<span>{$LANG.creditcardcardstart}:</span>{$cardstart}{/if}
                    </div>
                    <div class="card-expiry">
                        {if $cardexp}<span>{$LANG.creditcardcardexpires}:</span>{$cardexp}{/if}
                    </div>
                </div>           
            </div>
            {if $allowcustomerdelete && $cardtype}
                <form method="post" action="clientarea.php?action=creditcard">
                    <input type="hidden" name="remove" value="1" />                
                    <button type="submit" class="btn btn-link btn-sm btn-block credit-card-remove" data-toggle="confirmation" data-btn-ok-label="{lang key='yes'}" data-btn-ok-icon="fa fa-check" data-btn-ok-class="btn-success" data-btn-cancel-label="{lang key='no'}" data-btn-cancel-icon="fa fa-ban" data-btn-cancel-class="btn-default" data-title="{lang key='creditcarddelete'}" data-content="{lang key='creditCard.removeDescription'}" data-popout="true">
                        <i class="ls ls-trash"></i>{$LANG.creditcarddelete}
                    </button>
                </form>
            {/if} 
        </div>
        {else}
            <div class="message message-sm message-no-data credit-card">
                <div class="message-image">
                    {include file="$template//assets/svg-icon/credit-card.tpl"}        
                </div>
                <h6 class="message-text">{$LANG.creditcardnonestored}</h6>
            </div>    
        {/if}
        <h3>{$LANG.creditcardenternewcard}</h3>
        <form id="frmNewCc" role="form" method="post" action="{$smarty.server.PHP_SELF}?action=creditcard">
            <div class="alert alert-danger text-center gateway-errors hidden"></div>
            <div class="panel panel-default panel-form">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-6 form-group">
                        
                                <label for="inputCardType" class="control-label">{$LANG.creditcardcardtype}</label>
                                <select name="cctype" id="inputCardType" class="form-control">
                                    {foreach from=$acceptedcctypes item=fieldcardtype}
                                    <option {if $fieldcardtype eq $cardtype}selected{/if}>{$fieldcardtype}</option>
                                    {/foreach}
                                </select> 
                            
                        </div>
                        <div class="col-sm-6 form-group">
                        
                                <label for="inputCardNumber" class="control-label">{$LANG.creditcardcardnumber}</label>
                                <input type="tel" class="form-control" id="inputCardNumber" name="ccnumber" autocomplete="off" />
                            
                        </div>
                    </div>        
                    <div class="row">
                        {if $showccissuestart}
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label for="inputCardStart" class="control-label">{$LANG.creditcardcardstart}</label>
                                    <div class="row row-sm">
                                        <div class="col-xs-6">
                                            <select name="ccstartmonth" id="inputCardStart" class="form-control select-inline">
                                                {foreach from=$months item=month}
                                                <option{if $ccstartmonth eq $month} selected{/if}>{$month}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                        <div class="col-xs-6">    
                                            <select name="ccstartyear" class="form-control select-inline">
                                                {foreach from=$startyears item=year}
                                                <option{if $ccstartyear eq $year} selected{/if}>{$year}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>    
                        {/if}

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="inputCardExpiry" class="control-label">{$LANG.creditcardcardexpires}</label>
                                <div class="select-inline-container">
                                    <div class="row row-sm">
                                        <div class="col-xs-6">
                                            <select name="ccexpirymonth" id="inputCardExpiry" class="form-control">
                                                {foreach from=$months item=month}
                                                <option{if $ccstartmonth eq $month} selected{/if}>{$month}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                        <div class="col-xs-6">
                                            <select name="ccexpiryyear" class="form-control">
                                                {foreach from=$expiryyears item=year}
                                                <option{if $ccstartyear eq $year} selected{/if}>{$year}</option>
                                                {/foreach}
                                            </select>
                                        </div>  
                                    </div>      
                                </div>
                            </div>
                        </div>
                        {if $showccissuestart}
                            </div>
                    <div class="row">
                        {/if}
                        {if $showccissuestart}
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="inputCardIssue" class="control-label">{$LANG.creditcardcardissuenum}</label>
                                <input type="tel" class="form-control" id="inputCardIssue" name="ccissuenum" autocomplete="off" />
                            </div>
                        </div>    
                        {/if}
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="inputCardCVV" class="control-label">{$LANG.creditcardcvvnumber}</label>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-tooltip">
                                            <input type="tel" class="form-control" id="inputCardCVV" name="cardcvv" autocomplete="off" />
                                            <i class="ls ls-info-circle tooltip-icon" data-cc-popover-show></i>
                                            <div data-cc-popover class="popover top"> 
                                                <div class="arrow"></div>                                            
                                                <div class="popover-content"> 
                                                    <img src='{$BASE_PATH_IMG}/ccv.gif' width='180' />
                                                </div> 
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>                
                    </div>
                </div>            
                <div class="panel-footer">
                    <input class="btn btn-primary" id="btnSubmitNewCard" type="submit" name="submit" value="{$LANG.clientareasavechanges}" />
                    <input class="btn btn-default" type="reset" value="{$LANG.clientareacancel}" />
                </div>
            </div>
        </form>
    {/if}
{/if}    