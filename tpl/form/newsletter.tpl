[{if $oxcmp_shop->oxshops__oxproductive->value}]
    [{oxscript include="js/widget/validate.min.js" priority=10}]
[{else}]
    [{oxscript include="js/widget/validate.js" priority=10}]
[{/if}]

[{assign var="aRegParams" value=$oView->getRegParams()}]
<form action="[{$oViewConf->getSslSelfLink()}]" method="post" class="needs-validation" novalidate>
    [{block name="newsletter_form_fields"}]
        <div class="d-none">
            [{$oViewConf->getHiddenSid()}]
            <input type="hidden" name="fnc" value="send">
            <input type="hidden" name="cl" value="newsletter">
            <input type="hidden" name="editval[oxuser__oxcountryid]" value="[{$oView->getHomeCountryId()}]">
        </div>

        <div class="form-floating mb-3">
            [{include file="form/fieldset/salutation.tpl"
                name="editval[oxuser__oxsal]"
                value=$aRegParams.oxuser__oxsal
                class="form-control show-tick"
                id="newsletterSal"}]
            <label for="newsletterSal">[{oxmultilang ident="TITLE"}]</label>
            <div class="invalid-feedback">
                [{oxmultilang ident="DD_FORM_VALIDATION_TITLE"}]
            </div>
        </div>

        <div class="form-floating mb-3">
            <input class="form-control" id="newsletterFname" placeholder="[{oxmultilang ident="FIRST_NAME"}]" type="text" name="editval[oxuser__oxfname]" maxlength="40" value="[{if $aRegParams.oxuser__oxfname}][{$aRegParams.oxuser__oxfname}][{/if}]">
            <label for="newsletterFname">[{oxmultilang ident="FIRST_NAME"}]</label>
            <div class="invalid-feedback">
                [{oxmultilang ident="DD_FORM_VALIDATION_TITLE"}]
            </div>
        </div>

        <div class="form-floating mb-3">
            <input class="form-control" id="newsletterLname" placeholder="[{oxmultilang ident="LAST_NAME"}]" type="text" name="editval[oxuser__oxlname]" maxlength="40" value="[{if $aRegParams.oxuser__oxlname}][{$aRegParams.oxuser__oxlname}][{/if}]">
            <label for="newsletterLname">[{oxmultilang ident="LAST_NAME"}]</label>
        </div>

        <div class="form-floating mb-3">
            <input id="newsletterUserName" type="email" class="form-control" name="editval[oxuser__oxusername]" placeholder="[{oxmultilang ident="EMAIL"}]*" maxlength="40" value="[{if $aRegParams.oxuser__oxusername}][{$aRegParams.oxuser__oxusername}][{/if}]" required>
            <label for="newsletterUserName">[{oxmultilang ident="EMAIL"}]*</label>
            <div class="invalid-feedback">
                [{oxmultilang ident="DD_FORM_VALIDATION_VALIDEMAIL"}]
            </div>
        </div>

        <div class="mb-3 col-lg-5">
            <div class="form-check">
                <input type="radio" class="form-check-input" id="newsletterSubscribeOn" name="subscribeStatus" value="1" checked>
                <label class="form-check-label" for="newsletterSubscribeOn">[{oxmultilang ident="SUBSCRIBE"}]</label>
            </div>
            <div class="form-check">
                <input type="radio" class="form-check-input" id="newsletterSubscribeOff" name="subscribeStatus" value="0">
                <label class="form-check-label" for="newsletterSubscribeOff">[{oxmultilang ident="UNSUBSCRIBE"}]</label>
            </div>
        </div>

    [{/block}]

    [{block name="captcha_form"}][{if method_exists($oViewConf, 'getCaptchaWidget')}][{$oViewConf->getCaptchaWidget('newsletter')}][{/if}][{/block}]

    [{block name="newsletter_form_button"}]
        <p class="alert alert-info">[{oxmultilang ident="COMPLETE_MARKED_FIELDS"}]</p>
        <button id="newsLetterSubmit" class="btn btn-primary" type="submit">[{oxmultilang ident="SUBMIT"}]</button>
    [{/block}]
</form>