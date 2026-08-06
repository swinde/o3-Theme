[{if $oxcmp_shop->oxshops__oxproductive->value}]
    [{oxscript include="js/widget/validate.min.js" priority=10}]
[{else}]
    [{oxscript include="js/widget/validate.js" priority=10}]
[{/if}]

<form action="[{$oViewConf->getSelfActionLink()}]" name="changepassword" method="post" class="needs-validation" novalidate>
    [{assign var="aErrors" value=$oView->getFieldValidationErrors()}]

    <div class="d-none">
        [{$oViewConf->getHiddenSid()}]
        [{$oViewConf->getNavFormParams()}]
        <input type="hidden" name="fnc" value="changePassword">
        <input type="hidden" name="cl" value="account_password">
        <input type="hidden" name="CustomError" value='user'>
        <input type="hidden" id="passwordLength" value="[{$oViewConf->getPasswordLength()}]">
    </div>

    <div class="form-floating mb-3">
        <input type="password" id="passwordOld" name="password_old" class="form-control" placeholder="[{oxmultilang ident="OLD_PASSWORD"}]" required autocomplete="current-password">
        <label for="passwordOld">[{oxmultilang ident="OLD_PASSWORD"}]</label>
        <div class="invalid-feedback">
            [{oxmultilang ident="O3_FORM_VALIDATION_OLD_PASSWORD"}]
        </div>
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxpassword}]
    </div>

    [{block name="user_account_password"}]
        <div class="mb-3">

            <input type="hidden" data-js="password-length" value="[{$oViewConf->getPasswordLength()}]">

            <div class="input-group has-validation">
                <div class="form-floating flex-grow-1">
                    <input id="userPassword" type="password" name="password_new" class="form-control border-end-0" placeholder="[{oxmultilang ident="NEW_PASSWORD"}]" required autocomplete="new-password">
                    <label for="userPassword">[{oxmultilang ident="NEW_PASSWORD"}]</label>
                </div>
                <button class="btn btn-input border-start-0" type="button" data-js="toggle-password" data-target="userPassword" aria-label="Passwort anzeigen" aria-pressed="false">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#DBDBDB" viewBox="0 0 16 16">
                        <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0"/>
                        <path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8m8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7"/>
                    </svg>
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#DBDBDB" viewBox="0 0 16 16">
                        <path d="m10.79 12.912-1.614-1.615a3.5 3.5 0 0 1-4.474-4.474l-2.06-2.06C.938 6.278 0 8 0 8s3 5.5 8 5.5a7 7 0 0 0 2.79-.588M5.21 3.088A7 7 0 0 1 8 2.5c5 0 8 5.5 8 5.5s-.939 1.721-2.641 3.238l-2.062-2.062a3.5 3.5 0 0 0-4.474-4.474z"/>
                        <path d="M5.525 7.646a2.5 2.5 0 0 0 2.829 2.829zm4.95.708-2.829-2.83a2.5 2.5 0 0 1 2.829 2.829zm3.171 6-12-12 .708-.708 12 12z"/>
                    </svg>
                </button>
                <div class="invalid-feedback">
                    [{oxmultilang ident="O3_FORM_VALIDATION_PASSWORD"}]
                </div>
            </div>
            [{include file="form/fieldset/password_validation.tpl"}]
            [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxpassword}]
        </div>
    [{/block}]

    <div class="mb-3">
        <div class="input-group has-validation">
            <div class="form-floating flex-grow-1">
                <input id="userPasswordConfirm" type="password" name="password_new_confirm" class="form-control border-end-0" placeholder="[{oxmultilang ident="CONFIRM_PASSWORD"}]" required autocomplete="new-password">
                <label for="userPasswordConfirm">[{oxmultilang ident="CONFIRM_PASSWORD"}]</label>
            </div>
            <button class="btn btn-input border-start-0" type="button" data-js="toggle-password" data-target="userPasswordConfirm" aria-label="Passwort anzeigen" aria-pressed="false">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#DBDBDB" viewBox="0 0 16 16">
                    <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0"/>
                    <path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8m8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7"/>
                </svg>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#DBDBDB" viewBox="0 0 16 16">
                    <path d="m10.79 12.912-1.614-1.615a3.5 3.5 0 0 1-4.474-4.474l-2.06-2.06C.938 6.278 0 8 0 8s3 5.5 8 5.5a7 7 0 0 0 2.79-.588M5.21 3.088A7 7 0 0 1 8 2.5c5 0 8 5.5 8 5.5s-.939 1.721-2.641 3.238l-2.062-2.062a3.5 3.5 0 0 0-4.474-4.474z"/>
                    <path d="M5.525 7.646a2.5 2.5 0 0 0 2.829 2.829zm4.95.708-2.829-2.83a2.5 2.5 0 0 1 2.829 2.829zm3.171 6-12-12 .708-.708 12 12z"/>
                </svg>
            </button>
            <div class="invalid-feedback">
                [{oxmultilang ident="O3_FORM_VALIDATION_NEW_PASSWORD"}]
            </div>
            [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxpassword}]
        </div>
    </div>

    <button id="savePass" type="submit" class="btn btn-primary" role="button">[{oxmultilang ident="SAVE"}]</button>

</form>
