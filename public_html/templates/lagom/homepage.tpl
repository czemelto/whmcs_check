{if isset($RSThemes.pages.homepage)}
    {include file=$RSThemes['pages']['homepage']['fullPath']}
{else}
	{if $RSThemes.layouts.vars.type != "navbar-left"}
		<div class="app-main">
	{/if}
    <div class="site site-index site-index-default">
	<div class="main-body has-banner home">
		<div class="main-banner banner-home">
			<div class="container text-center">
				{if $registerdomainenabled || $transferdomainenabled}
					<h2 class="banner-title">{$LANG.findyourdomain}</h2>
					<form method="post" action="domainchecker.php" id="frmDomainHomepage">
						<input type="hidden" name="transfer" />
						<div class="search-box input-group input-group-lg">
							<i class="input-group-icon fa fa-search lm lm-search"></i>
							<input type="text" class="form-control" name="domain" placeholder="{$LANG.exampledomain}" autocapitalize="none" data-toggle="tooltip" data-placement="left" data-trigger="manual" title="{lang key='orderForm.required'}"/>
							<div class="input-group-btn">
								{if $registerdomainenabled}
									<input type="submit" class="btn btn-primary search {$captcha->getButtonClass($captchaForm)}" value="{$LANG.search}" id="btnDomainSearch"/>
								{/if}
							</div>
						</div>
						{include file="$template/includes/captcha.tpl"}
					</form>
				{else}
					<h2 class="banner-title">{$LANG.doToday}</h2>
				{/if}
			</div>            
			{if file_exists("templates/$template/assets/svg-illustrations/banner-bg.tpl")}
				{include file="{$template}/assets/svg-illustrations/banner-bg.tpl"}
			{/if}
		</div>
		<div class="main-section">
			<div class="container">
				<div class="m-w-928 m-h-a">
					<div class="section">
						<div class="section-header">
							<h3>{$LANG.howcanwehelp}</h3>
						</div>
						<div class="homepage-tiles row m-b-24">
							{if $registerdomainenabled || $transferdomainenabled}
								<div class="col-sm-3">
									<a class="tile tile-home" href="domainchecker.php">
										{include file="$template//assets/svg-icon/domain.tpl"}
										<span class="title">{$LANG.buyadomain}</span>
									</a>
								</div>
							{/if}
							<div class="col-sm-3">
								<a id="btnOrderHosting" class="tile tile-home" href="cart.php">
									{include file="$template//assets/svg-icon/web-hosting.tpl"}
									<span class="title">{$LANG.orderhosting}</span>
								</a>
							</div>
							<div class="col-sm-3">
								<a id="btnMakePayment" class="tile tile-home" href="clientarea.php">
									{include file="$template//assets/svg-icon/comissions.tpl"}
									<span class="title">{$LANG.makepayment}</span>
								</a>
							</div>
							<div class="col-sm-3">
			
								<a id="btnGetSupport" class="tile tile-home" href="submitticket.php">
									{include file="$template//assets/svg-icon/addon-email-forwarding.tpl"}
									<span class="title">{$LANG.getsupport}</span>
								</a>
							</div>
						</div>
					</div>
				{if $twitterusername}
					<div class="section">
						<div class="section-header">
							<h3>{$LANG.twitterlatesttweets}</h3>
						</div>
						<div class="panel" id="twitterFeedOutput">
								<div class="loader d-flex justify-center">
									{include file="$template/includes/loader.tpl"}
								</div>
							
						</div>
						<script type="text/javascript" src="{$WEB_ROOT}/templates/{$template}/assets/js/twitter.js"></script>
					</div>
				{elseif $announcements}
					<div class="section">
						<div class="section-header">
						<h3 class="d-flex space-between">{$LANG.news}<i class="lm lm-info-text text-lighter"></i></h3>
						</div>
						<div class="annoucements">
					{foreach $announcements as $announcement}
						{if $announcement@index < 2}
							<div class="announcement-item" data-href="{routePath('announcement-view', $announcement.id, $announcement.urlfriendlytitle)}">
								<span class="announcement-title">{$announcement.title}</span>
								<div class="announcement-body">
									<p>
										{if $announcement.text|strip_tags|strlen < 350}
											{$announcement.text}
										{else}
											{$announcement.summary}
										{/if}
									</p>
								</div>
								<div class="announcement-footer">
									{if $announcement.text|strip_tags|strlen >= 350}
										<span class="btn btn-sm btn-info">{$LANG.readmore}</span>
									{/if}
									<div class="announcement-details">
										{if $announcementsFbRecommend}
											<script>
												(function(d, s, id) {
													var js, fjs = d.getElementsByTagName(s)[0];
													if (d.getElementById(id)) {
														return;
													}
													js = d.createElement(s); js.id = id;
													js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
													fjs.parentNode.insertBefore(js, fjs);
												}(document, 'script', 'facebook-jssdk'));
											</script>
											<div class="fb-like hidden-sm hidden-xs" data-layout="standard" data-href="{fqdnRoutePath('announcement-view', $announcement.id, $announcement.urlfriendlytitle)}" data-send="true" data-width="450" data-show-faces="true" data-action="recommend"></div>
											<div class="fb-like hidden-lg hidden-md" data-layout="button_count" data-href="{fqdnRoutePath('announcement-view', $announcement.id, $announcement.urlfriendlytitle)}" data-send="true" data-width="450" data-show-faces="true" data-action="recommend"></div>
										{/if}
										<span class="announcement-date">{$carbon->translatePassedToFormat($announcement.rawDate, 'M jS')}</span>
									</div>
								</div>
							</div>
						{/if}
					{/foreach}
					</div>
					</div>
				{/if}
				</div>
			</div>    
		</div>
	</div>
            </div>
	{if $RSThemes.layouts.vars.type != "navbar-left"}
		</div>
	{/if}
{/if}	