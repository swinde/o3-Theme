[{if $oxcmp_shop->oxshops__oxproductive->value}]
    [{oxscript include="js/widget/validate.min.js" priority=10}]
[{else}]
    [{oxscript include="js/widget/validate.js" priority=10}]
[{/if}]

<form action="[{$oViewConf->getSelfActionLink()}]" name="forgotpwd" method="post" class="needs-validation" novalidate>

    <div class="d-none">
        [{$oViewConf->getHiddenSid()}]
        [{$oViewConf->getNavFormParams()}]
        <input type="hidden" name="fnc" value="forgotpassword">
        <input type="hidden" name="cl" value="forgotpwd">
        <input type="hidden" name="actcontrol" value="forgotpwd">
    </div>

    [{oxmultilang ident="REQUEST_PASSWORD_AFTERCLICK"}]<br><br>
    [{oxifcontent ident="oxforgotpwd" object="oCont"}]
        [{$oCont->oxcontents__oxcontent->value}]
    [{/oxifcontent}]

    <div class="form-floating mb-3">
        <input type="email" class="form-control" value="[{$oView->getActiveUsername()}]" id="forgotPasswordUserLoginName[{$idPrefix}]" name="lgn_usr" placeholder="[{oxmultilang ident="YOUR_EMAIL_ADDRESS"}]" required autocomplete="email">
        <label for="forgotPasswordUserLoginName">[{oxmultilang ident="YOUR_EMAIL_ADDRESS"}]</label>
        <div class="invalid-feedback">
            [{oxmultilang ident="DD_FORM_VALIDATION_VALIDEMAIL"}]
        </div>
    </div>

    [{block name="captcha_form"}][{if method_exists($oViewConf, 'getCaptchaWidget')}][{$oViewConf->getCaptchaWidget('forgotpwd')}][{/if}][{/block}]

    <button class="btn btn-primary" type="submit">[{oxmultilang ident="REQUEST_PASSWORD"}]</button>

</form>
