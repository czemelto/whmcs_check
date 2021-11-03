{if isset($RSThemes['pages']['account-user-permissions'])}
    {include file=$RSThemes['pages']['account-user-permissions']['fullPath']}
{else}
    <p class="text-light m-b-6">{lang key="userManagement.managePermissions"}:</p>  
    <ul class="list-group list-group-bordered list-group-lg">
        <li class="list-group-item">
            <i class="ls ls-check check-boxed"></i><span>{$user->email}</span>
        </li>
    </ul>
    <form class="section" method="post" action="{routePath('account-users-permissions-save', $user->id)}">    
        <div class="section-header">
            <h3>{lang key="userManagement.permissions"}</h3>
        </div>
        <div class="section-body">
            <div class="panel panel-default panel-form">
                <div class="panel-body">
                    {foreach $permissions as $permission}
                        <div class="checkbox">
                            <label>
                                <input class="icheck-control" type="checkbox" name="perms[{$permission.key}]" value="1"{if $userPermissions->hasPermission($permission.key)} checked{/if}>
                                
                                {$permission.title} - {$permission.description}
                            </label>
                        </div>
                    {/foreach}
                </div>
            </div>    
        </div>
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">
                {lang key="clientareasavechanges"}
            </button>
            <a href="{routePath('account-users')}" class="btn btn-default">
                {lang key="clientareacancel"}
            </a>
        </div>
    </form>
{/if}    