[{assign var="invadr" value=$oView->getInvoiceAddress()}]
[{assign var="blBirthdayRequired" value=$oView->isFieldRequired(oxuser__oxbirthdate)}]

[{if isset( $invadr.oxuser__oxbirthdate.month )}]
    [{assign var="iBirthdayMonth" value=$invadr.oxuser__oxbirthdate.month}]
[{elseif $oxcmp_user->oxuser__oxbirthdate->value && $oxcmp_user->oxuser__oxbirthdate->value != "0000-00-00"}]
    [{assign var="iBirthdayMonth" value=$oxcmp_user->oxuser__oxbirthdate->value|regex_replace:"/^([0-9]{4})[-]/":""|regex_replace:"/[-]([0-9]{1,2})$/":""}]
[{else}]
    [{assign var="iBirthdayMonth" value=0}]
[{/if}]

[{if isset( $invadr.oxuser__oxbirthdate.day )}]
    [{assign var="iBirthdayDay" value=$invadr.oxuser__oxbirthdate.day}]
[{elseif $oxcmp_user->oxuser__oxbirthdate->value && $oxcmp_user->oxuser__oxbirthdate->value != "0000-00-00"}]
    [{assign var="iBirthdayDay" value=$oxcmp_user->oxuser__oxbirthdate->value|regex_replace:"/^([0-9]{4})[-]([0-9]{1,2})[-]/":""}]
[{else}]
    [{assign var="iBirthdayDay" value=0}]
[{/if}]

[{if isset( $invadr.oxuser__oxbirthdate.year )}]
    [{assign var="iBirthdayYear" value=$invadr.oxuser__oxbirthdate.year}]
[{elseif $oxcmp_user->oxuser__oxbirthdate->value && $oxcmp_user->oxuser__oxbirthdate->value != "0000-00-00"}]
    [{assign var="iBirthdayYear" value=$oxcmp_user->oxuser__oxbirthdate->value|regex_replace:"/[-]([0-9]{1,2})[-]([0-9]{1,2})$/":""}]
[{else}]
    [{assign var="iBirthdayYear" value=0}]
[{/if}]
[{if isset( $invadr.oxuser__oxsal )}]
    [{assign var="oxuser__oxsal" value=$invadr.oxuser__oxsal}]
[{else}]
    [{assign var="oxuser__oxsal" value=$oxcmp_user->oxuser__oxsal->value}]
[{/if}]

<div class="form-floating mb-3">
    [{include file="form/fieldset/salutation.tpl" name="invadr[oxuser__oxsal]" value=$oxuser__oxsal class="form-select" id="invadr_oxuser__oxsal" required=$oView->isFieldRequired(oxuser__oxsal)}]
    <label for="invadr_oxuser__oxsal">[{oxmultilang ident="TITLE"}][{if $oView->isFieldRequired(oxuser__oxsal)}]*[{/if}]</label>
    <div class="invalid-feedback">
        [{oxmultilang ident="DD_FORM_VALIDATION_TITLE"}]
    </div>
</div>

<div class="form-floating mb-3">
    <input type="text" class="form-control" id="invadr_oxuser__oxfname" name="invadr[oxuser__oxfname]" value="[{if isset( $invadr.oxuser__oxfname )}][{$invadr.oxuser__oxfname}][{else}][{$oxcmp_user->oxuser__oxfname->value}][{/if}]" maxlength="255" placeholder="[{oxmultilang ident="FIRST_NAME"}][{if $oView->isFieldRequired(oxuser__oxfname)}]*[{/if}]"[{if $oView->isFieldRequired(oxuser__oxfname)}] required[{/if}] autocomplete="billing given-name">
    <label for="invadr_oxuser__oxfname">[{oxmultilang ident="FIRST_NAME"}][{if $oView->isFieldRequired(oxuser__oxfname)}]*[{/if}]</label>
    <div class="invalid-feedback">
        [{oxmultilang ident="DD_FORM_VALIDATION_FIRST_NAME"}]
    </div>
    [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxfname}]
</div>

<div class="form-floating mb-3">
    <input type="text" class="form-control" id="invadr_oxuser__oxlname" name="invadr[oxuser__oxlname]" value="[{if isset( $invadr.oxuser__oxlname )}][{$invadr.oxuser__oxlname}][{else}][{$oxcmp_user->oxuser__oxlname->value}][{/if}]" maxlength="255" placeholder="[{oxmultilang ident="LAST_NAME"}][{if $oView->isFieldRequired(oxuser__oxlname)}]*[{/if}]"[{if $oView->isFieldRequired(oxuser__oxlname)}] required[{/if}] autocomplete="billing family-name">
    <label for="invadr_oxuser__oxlname">[{oxmultilang ident="LAST_NAME"}][{if $oView->isFieldRequired(oxuser__oxlname)}]*[{/if}]</label>
    <div class="invalid-feedback">
        [{oxmultilang ident="DD_FORM_VALIDATION_LAST_NAME"}]
    </div>
    [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxlname}]
</div>

[{if $oViewConf->getViewThemeParam('bInputCompany') || $oView->isFieldRequired(oxuser__oxcompany)}]
    <div class="form-floating mb-3">
        <input type="text" class="form-control" id="invadr_oxuser__oxcompany" name="invadr[oxuser__oxcompany]" value="[{if isset( $invadr.oxuser__oxcompany )}][{$invadr.oxuser__oxcompany}][{else}][{$oxcmp_user->oxuser__oxcompany->value}][{/if}]" maxlength="255" placeholder="[{oxmultilang ident="COMPANY"}][{if $oView->isFieldRequired(oxuser__oxcompany)}]*[{/if}]"[{if $oView->isFieldRequired(oxuser__oxcompany)}] required[{/if}] autocomplete="billing organization">
        <label for="invadr_oxuser__oxcompany">[{oxmultilang ident="COMPANY"}][{if $oView->isFieldRequired(oxuser__oxcompany)}]*[{/if}]</label>
        <div class="invalid-feedback">
            [{oxmultilang ident="DD_FORM_VALIDATION_COMPANY"}]
        </div>
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxcompany}]
    </div>
[{/if}]

<div class="form-floating mb-3">
    <input type="text" class="form-control" id="invadr_oxuser__oxaddinfo" name="invadr[oxuser__oxaddinfo]" value="[{if isset( $invadr.oxuser__oxaddinfo )}][{$invadr.oxuser__oxaddinfo}][{else}][{$oxcmp_user->oxuser__oxaddinfo->value}][{/if}]" maxlength="255" placeholder="[{oxmultilang ident="ADDITIONAL_INFO"}][{if $oView->isFieldRequired(oxuser__oxaddinfo)}]*[{/if}]"[{if $oView->isFieldRequired(oxuser__oxaddinfo)}] required[{/if}]>
    <label for="invadr_oxuser__oxaddinfo">[{oxmultilang ident="ADDITIONAL_INFO"}][{if $oView->isFieldRequired(oxuser__oxaddinfo)}]*[{/if}]</label>
    <div class="invalid-feedback">
        [{oxmultilang ident="DD_FORM_VALIDATION_ADDITIONAL_INFO"}]
    </div>
    [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxaddinfo}]
</div>

<div class="row">
    <div class="form-floating mb-3 col-lg-9 pe-xl-0">
        <input type="text" class="form-control" id="invadr_oxuser__oxstreet" name="invadr[oxuser__oxstreet]" value="[{if isset( $invadr.oxuser__oxstreet )}][{$invadr.oxuser__oxstreet}][{else}][{$oxcmp_user->oxuser__oxstreet->value}][{/if}]" maxlength="255" placeholder="[{oxmultilang ident="O3_STREET"}][{if $oView->isFieldRequired(oxuser__oxstreet) || $oView->isFieldRequired(oxuser__oxstreetnr)}]*[{/if}]"[{if $oView->isFieldRequired(oxuser__oxstreet)}] required[{/if}] autocomplete="billing street-address">
        <label for="invadr_oxuser__oxstreet">[{oxmultilang ident="O3_STREET"}][{if $oView->isFieldRequired(oxuser__oxstreet) || $oView->isFieldRequired(oxuser__oxstreetnr)}]*[{/if}]</label>
        <div class="invalid-feedback">
            [{oxmultilang ident="DD_FORM_VALIDATION_STREET"}]
        </div>
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxstreet}]
    </div>
    <div class="form-floating mb-3 col-lg-3">
        <input type="text" class="form-control" id="invadr_oxuser__oxstreetnr" name="invadr[oxuser__oxstreetnr]" value="[{if isset( $invadr.oxuser__oxstreetnr )}][{$invadr.oxuser__oxstreetnr}][{else}][{$oxcmp_user->oxuser__oxstreetnr->value}][{/if}]" maxlength="16" placeholder="[{oxmultilang ident="O3_STREETNO"}][{if $oView->isFieldRequired(oxuser__oxstreet) || $oView->isFieldRequired(oxuser__oxstreetnr)}]*[{/if}]"[{if $oView->isFieldRequired(oxuser__oxstreetnr)}] required[{/if}]>
        <label for="invadr_oxuser__oxstreetnr">[{oxmultilang ident="O3_STREETNO"}][{if $oView->isFieldRequired(oxuser__oxstreet) || $oView->isFieldRequired(oxuser__oxstreetnr)}]*[{/if}]</label>
        <div class="invalid-feedback">
            [{oxmultilang ident="DD_FORM_VALIDATION_STREETNO"}]
        </div>
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxstreetnr}]
    </div>
</div>

<div class="row">
    <div class="form-floating mb-3 col-lg-3">
        <input type="text" class="form-control" id="invadr_oxuser__oxzip" name="invadr[oxuser__oxzip]" value="[{if isset( $invadr.oxuser__oxzip )}][{$invadr.oxuser__oxzip}][{else}][{$oxcmp_user->oxuser__oxzip->value}][{/if}]" maxlength="16" placeholder="[{oxmultilang ident="O3_POSTAL_CODE"}][{if $oView->isFieldRequired(oxuser__oxzip) || $oView->isFieldRequired(oxuser__oxcity)}]*[{/if}]"[{if $oView->isFieldRequired(oxuser__oxzip)}] required[{/if}] autocomplete="billing postal-code">
        <label for="invadr_oxuser__oxzip">[{oxmultilang ident="O3_POSTAL_CODE"}][{if $oView->isFieldRequired(oxuser__oxzip) || $oView->isFieldRequired(oxuser__oxcity)}]*[{/if}]</label>
        <div class="invalid-feedback">
            [{oxmultilang ident="DD_FORM_VALIDATION_POSTAL_CODE"}]
        </div>
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxzip}]
    </div>
    <div class="form-floating mb-3 col-lg-9 ps-xl-0">
        <input type="text" class="form-control" id="invadr_oxuser__oxcity" name="invadr[oxuser__oxcity]" value="[{if isset( $invadr.oxuser__oxcity )}][{$invadr.oxuser__oxcity}][{else}][{$oxcmp_user->oxuser__oxcity->value}][{/if}]" maxlength="255" placeholder="[{oxmultilang ident="O3_CITY"}][{if $oView->isFieldRequired(oxuser__oxzip) || $oView->isFieldRequired(oxuser__oxcity)}]*[{/if}]"[{if $oView->isFieldRequired(oxuser__oxcity)}] required[{/if}] autocomplete="billing locality">
        <label for="invadr_oxuser__oxcity">[{oxmultilang ident="O3_CITY"}][{if $oView->isFieldRequired(oxuser__oxzip) || $oView->isFieldRequired(oxuser__oxcity)}]*[{/if}]</label>
        <div class="invalid-feedback">
            [{oxmultilang ident="DD_FORM_VALIDATION_CITY"}]
        </div>
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxcity}]
    </div>
</div>

[{if $oViewConf->getViewThemeParam('bInputUstid') || $oView->isFieldRequired(oxuser__oxustid)}]
    <div class="form-floating mb-3">
        <input type="text" class="form-control" id="invadr_oxuser__oxustid" name="invadr[oxuser__oxustid]" value="[{if isset( $invadr.oxuser__oxustid )}][{$invadr.oxuser__oxustid}][{else}][{$oxcmp_user->oxuser__oxustid->value}][{/if}]" maxlength="255" placeholder="[{oxmultilang ident="VAT_ID_NUMBER"}][{if $oView->isFieldRequired(oxuser__oxustid)}]*[{/if}]"[{if $oView->isFieldRequired(oxuser__oxustid)}] required[{/if}]>
        <label for="invadr_oxuser__oxustid">[{oxmultilang ident="VAT_ID_NUMBER"}][{if $oView->isFieldRequired(oxuser__oxustid)}]*[{/if}]</label>
        <div class="invalid-feedback">
            [{oxmultilang ident="DD_FORM_VALIDATION_VAT_ID_NUMBER"}]
        </div>
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxustid}]
    </div>
[{/if}]

[{block name="form_user_billing_country"}]
    <div class="form-floating mb-3">
        <select class="form-select" id="invCountrySelect" name="invadr[oxuser__oxcountryid]"[{if $oView->isFieldRequired(oxuser__oxcountryid)}] required[{/if}] autocomplete="billing country">
            <option value="">-</option>
            [{assign var="blCountrySelected" value=false}]
            [{foreach from=$oViewConf->getCountryList() item=country key=country_id}]
                [{assign var="sCountrySelect" value=""}]
                [{if !$blCountrySelected}]
                    [{if (isset($invadr.oxuser__oxcountryid) && $invadr.oxuser__oxcountryid == $country->oxcountry__oxid->value) ||
                    (!isset($invadr.oxuser__oxcountryid) && $oxcmp_user->oxuser__oxcountryid->value == $country->oxcountry__oxid->value)}]
                        [{assign var="blCountrySelected" value=true}]
                        [{assign var="sCountrySelect" value="selected"}]
                    [{/if}]
                [{/if}]
                <option value="[{$country->oxcountry__oxid->value}]" [{$sCountrySelect}]>[{$country->oxcountry__oxtitle->value}]</option>
            [{/foreach}]
        </select>
        <label for="invCountrySelect">[{oxmultilang ident="COUNTRY"}][{if $oView->isFieldRequired(oxuser__oxcountryid)}]*[{/if}]</label>
        <div class="invalid-feedback">
            [{oxmultilang ident="DD_FORM_VALIDATION_COUNTRY"}]
        </div>
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxcountryid}]
    </div>

    [{if $oViewConf->getViewThemeParam('bInputState') || $oView->isFieldRequired(oxuser__oxstateid)}]
        <div class="form-floating mb-3">
            [{include file="form/fieldset/state.tpl"
            countrySelectId="invCountrySelect"
            stateSelectName="invadr[oxuser__oxstateid]"
            selectedStateIdPrim=$invadr.oxuser__oxstateid
            selectedStateId=$oxcmp_user->oxuser__oxstateid->value
            class="form-select"
            id="invadr_oxuser__oxstateid"
            }]
            <label for="invadr_oxuser__oxstateid">[{oxmultilang ident="DD_USER_LABEL_STATE"}][{if $oView->isFieldRequired(oxuser__oxstateid)}]*[{/if}]</label>
            <div class="invalid-feedback">
                [{oxmultilang ident="DD_FORM_VALIDATION_STATE"}]
            </div>
        </div>
    [{/if}]
[{/block}]

<div class="form-floating mb-3">
    <input type="text" class="form-control" id="invadr_oxuser__oxfon" name="invadr[oxuser__oxfon]" value="[{if isset( $invadr.oxuser__oxfon )}][{$invadr.oxuser__oxfon}][{else}][{$oxcmp_user->oxuser__oxfon->value}][{/if}]" maxlength="128" placeholder="[{oxmultilang ident="PHONE"}][{if $oView->isFieldRequired(oxuser__oxfon)}]*[{/if}]"[{if $oView->isFieldRequired(oxuser__oxfon)}] required[{/if}] autocomplete="billing tel">
    <label for="invadr_oxuser__oxfon">[{oxmultilang ident="PHONE"}][{if $oView->isFieldRequired(oxuser__oxfon)}]*[{/if}]</label>
    <div class="invalid-feedback">
        [{oxmultilang ident="DD_FORM_VALIDATION_PHONE"}]
    </div>
    [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxfon}]
</div>

[{if $oViewConf->getViewThemeParam('bInputFax') || $oView->isFieldRequired(oxuser__oxfax)}]
    <div class="form-floating mb-3">
        <input type="text" class="form-control" id="invadr_oxuser__oxfax" name="invadr[oxuser__oxfax]" value="[{if isset( $invadr.oxuser__oxfax )}][{$invadr.oxuser__oxfax}][{else}][{$oxcmp_user->oxuser__oxfax->value}][{/if}]" maxlength="128" placeholder="[{oxmultilang ident="FAX"}][{if $oView->isFieldRequired(oxuser__oxfax)}]*[{/if}]"[{if $oView->isFieldRequired(oxuser__oxfax)}] required[{/if}] autocomplete="billing fax">
        <label for="invadr_oxuser__oxfax">[{oxmultilang ident="FAX"}][{if $oView->isFieldRequired(oxuser__oxfax)}]*[{/if}]</label>
        <div class="invalid-feedback">
            [{oxmultilang ident="DD_FORM_VALIDATION_FAX"}]
        </div>
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxfax}]
    </div>
[{/if}]

[{if $oViewConf->getViewThemeParam('bInputMobilePhone') || $oView->isFieldRequired(oxuser__oxmobfon)}]
    <div class="form-floating mb-3">
        <input type="text" class="form-control" id="invadr_oxuser__oxmobfon" name="invadr[oxuser__oxmobfon]" value="[{if isset( $invadr.oxuser__oxmobfon )}][{$invadr.oxuser__oxmobfon}][{else}][{$oxcmp_user->oxuser__oxmobfon->value}][{/if}]" maxlength="64" placeholder="[{oxmultilang ident="CELLUAR_PHONE"}][{if $oView->isFieldRequired(oxuser__oxmobfon)}]*[{/if}]"[{if $oView->isFieldRequired(oxuser__oxmobfon)}] required[{/if}]>
        <label for="invadr_oxuser__oxfon">[{oxmultilang ident="CELLUAR_PHONE"}][{if $oView->isFieldRequired(oxuser__oxmobfon)}]*[{/if}]</label>
        <div class="invalid-feedback">
            [{oxmultilang ident="DD_FORM_VALIDATION_CELLUAR_PHONE"}]
        </div>
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxmobfon}]
    </div>
[{/if}]

[{if $oViewConf->getViewThemeParam('bInputPrivatPhone') || $oView->isFieldRequired(oxuser__oxprivfon)}]
    <div class="form-floating mb-3">
        <input type="text" class="form-control" id="invadr_oxuser__oxprivfon" name="invadr[oxuser__oxprivfon]" value="[{if isset( $invadr.oxuser__oxprivfon )}][{$invadr.oxuser__oxprivfon}][{else}][{$oxcmp_user->oxuser__oxprivfon->value}][{/if}]" maxlength="64" placeholder="[{oxmultilang ident="PERSONAL_PHONE"}][{if $oView->isFieldRequired(oxuser__oxprivfon)}]*[{/if}]"[{if $oView->isFieldRequired(oxuser__oxprivfon)}] required[{/if}]>
        <label for="invadr_oxuser__oxprivfon">[{oxmultilang ident="PERSONAL_PHONE"}][{if $oView->isFieldRequired(oxuser__oxprivfon)}]*[{/if}]</label>
        <div class="invalid-feedback">
            [{oxmultilang ident="DD_FORM_VALIDATION_PERSONAL_PHONE"}]
        </div>
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxprivfon}]
    </div>
[{/if}]

[{block name="form_user_billing_birthdate"}]
    [{if $oViewConf->showBirthdayFields()}]

        [{if $oxcmp_shop->oxshops__oxproductive->value}]
            [{oxscript include="js/widget/birthdate.min.js" priority=10}]
        [{else}]
            [{oxscript include="js/widget/birthdate.js" priority=10}]
        [{/if}]

        [{assign var="birthdate_complete" value="`$iBirthdayYear`-`$iBirthdayMonth`-`$iBirthdayDay`"}]

        <div class="form-floating mb-3">
            <input data-js="birthdate" id="invadr_oxuser__oxbirthdate" class="form-control" type="date" [{if $birthdate_complete}]value="[{$birthdate_complete}]"[{/if}] placeholder="[{oxmultilang ident="BIRTHDATE"}][{if $oView->isFieldRequired(oxuser__oxbirthdate)}]*[{/if}]"[{if $oView->isFieldRequired(oxuser__oxbirthdate)}] required[{/if}]>
            <label for="invadr_oxuser__oxbirthdate">[{oxmultilang ident="BIRTHDATE"}][{if $oView->isFieldRequired(oxuser__oxbirthdate)}]*[{/if}]</label>
            <div class="invalid-feedback">
                [{oxmultilang ident="O3_FORM_VALIDATION_BIRTHDATE"}]
            </div>
            [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxbirthdate}]

            <input type="hidden" data-js="birthdate-day" name="invadr[oxuser__oxbirthdate][day]" value="[{if $iBirthdayDay}][{$iBirthdayDay}][{/if}]">
            <input type="hidden" data-js="birthdate-month" name="invadr[oxuser__oxbirthdate][month]" value="[{if $iBirthdayMonth}][{$iBirthdayMonth}][{/if}]">
            <input type="hidden" data-js="birthdate-year" name="invadr[oxuser__oxbirthdate][year]" value="[{if $iBirthdayYear}][{$iBirthdayYear}][{/if}]">

        </div>

    [{/if}]
[{/block}]

[{block name="captcha_form"}][{if !$oxcmp_user->oxuser__oxpassword->value && method_exists($oViewConf, 'getCaptchaWidget')}][{$oViewConf->getCaptchaWidget('register')}][{/if}][{/block}]

<p class="alert alert-info">[{oxmultilang ident="COMPLETE_MARKED_FIELDS"}]</p>

[{if !$noFormSubmit}]
    <button id="accUserSaveTop" type="submit" name="save" class="btn btn-primary">[{oxmultilang ident="SAVE"}]</button>
[{/if}]
