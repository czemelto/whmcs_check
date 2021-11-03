{if isset($RSThemes.pages.clientareadomainregisterns)}
    {include file=$RSThemes['pages']['clientareadomainregisterns']['fullPath']}
{else} 
	<div class="section">
		<h3>{$LANG.domainregisterns}</h3>
		<p class="text-light">{$LANG.domainregisternsexplanation}</p>

		{if $result}
			{include file="$template/includes/alert.tpl" type="warning" msg=$result textcenter=true}
		{/if}
	</div>

	<div class="section">
		<div class="section-header">
			<h3>{$LANG.domainregisternsreg}</h3>
		</div>
		<div class="section-boduy">
			<form role="form" method="post" action="{$smarty.server.PHP_SELF}?action=domainregisterns">
				<div class="panel panel-default panel-form">
					<div class="panel-body">
						<input type="hidden" name="sub" value="register" />
						<input type="hidden" name="domainid" value="{$domainid}" />
						<div class="form-group">
							<label for="inputNs1" class="control-label">{$LANG.domainregisternsns}</label>
							<div class="row row-eq-height row-eq-height-sm">
								<div class="col-xs-6">
									<input type="text" class="form-control" id="inputNs1" name="ns" />
								</div>
								<div class="col-xs-6 align-center">
									. {$domain}
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-6">
								<div class="form-group">
									<label for="inputIp1" class="control-label">{$LANG.domainregisternsip}</label>
									<input type="text" class="form-control" id="inputIp1" name="ipaddress"/>
								</div>
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<input type="submit" value="{$LANG.clientareasavechanges}" class="btn btn-primary"/>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="section">
		<div class="section-header">
			<h3>{$LANG.domainregisternsmod}</h3>
		</div>
		<div class="section-boduy">
			<form role="form" method="post" action="{$smarty.server.PHP_SELF}?action=domainregisterns">
				<div class="panel panel-default panel-form">
					<div class="panel-body">
						<input type="hidden" name="sub" value="modify" />
						<input type="hidden" name="domainid" value="{$domainid}" />
						<div class="form-group">
							<label for="inputNs2" class="control-label">{$LANG.domainregisternsns}</label>
							<div class="row row-eq-height row-eq-height-sm">
								<div class="col-xs-6">
									<input type="text" class="form-control" id="inputNs2" name="ns" />
								</div>
								<div class="col-xs-6 align-center">
									. {$domain}
								</div>
							</div>    
						</div>
						<div class="row">
							<div class="col-sm-6">
								<div class="form-group">
									<label for="inputIp2" class="control-label">{$LANG.domainregisternscurrentip}</label>
									<input type="text" class="form-control" id="inputIp2" name="currentipaddress" />
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-group">
									<label for="inputIp3" class="control-label">{$LANG.domainregisternsnewip}</label>
									<input type="text" class="form-control" id="inputIp3" name="newipaddress" />
								</div>
							</div>
						</div> 
					</div>
					<div class="panel-footer">
						<input type="submit" value="{$LANG.clientareasavechanges}" class="btn btn-primary" />
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="section">
		<div class="section-header">
			<h3>{$LANG.domainregisternsdel}</h3>
		</div>
		<div class="section-boduy">
			<form role="form" method="post" action="{$smarty.server.PHP_SELF}?action=domainregisterns">
				<div class="panel panel-default panel-form">
					<div class="panel-body">
						<input type="hidden" name="sub" value="delete" />
						<input type="hidden" name="domainid" value="{$domainid}" />
						<div class="form-group">
							<label for="inputNs3" class="control-label">{$LANG.domainregisternsns}</label>
							<div class="row row-eq-height row-eq-height-sm">
								<div class="col-sm-6">           
									<input type="text" class="form-control" id="inputNs3" name="ns" />
								</div>
								<div class="col-sm-6 align-center">
									. {$domain}
								</div>
							</div>    
						</div>
					</div>
					<div class="panel-footer">
						<input type="submit" value="{$LANG.clientareasavechanges}" class="btn btn-primary" />
					</div>
				</div>
			</form>
		</div>
	</div>
{/if}	