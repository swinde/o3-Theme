[{if $oxcmp_shop->oxshops__oxproductive->value}]
    [{oxscript include="js/widget/validate.min.js" priority=10}]
[{else}]
    [{oxscript include="js/widget/validate.js" priority=10}]
[{/if}]

[{assign var="currency" value=$oView->getActCurrency()}]
<p class="alert alert-info">[{oxmultilang ident="MESSAGE_PRICE_ALARM_PRICE_CHANGE"}]</p>

<form action="[{$oViewConf->getSelfActionLink()}]" name="pricealarm" method="post" class="needs-validation" novalidate>
    <div class="d-none">
        [{$oViewConf->getHiddenSid()}]
        [{$oViewConf->getNavFormParams()}]
        <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]">
        [{if $oDetailsProduct}]
            <input type="hidden" name="anid" value="[{$oDetailsProduct->oxarticles__oxid->value}]">
        [{/if}]
        <input type="hidden" name="fnc" value="addme">
    </div>

    <div class="form-floating mb-3">
        <input type="text" class="form-control" id="price" name="pa[price]" maxlength="32" value="[{oxhasrights ident="SHOWARTICLEPRICE"}][{if $product}][{$product->getFPrice()}][{/if}][{/oxhasrights}]" placeholder="[{oxmultilang ident="YOUR_PRICE"}] ([{$currency->sign}])" required>
        <label for="price">[{oxmultilang ident="YOUR_PRICE"}] ([{$currency->sign}])</label>
        <div class="invalid-feedback">[{oxmultilang ident="O3_PRICEALARM_FEEDBACK"}]</div>
    </div>

    <div class="form-floating mb-3">
        <input type="email" class="form-control" id="email" name="pa[email]" value="[{if $oxcmp_user}][{$oxcmp_user->oxuser__oxusername->value}][{/if}]" maxlength="128" placeholder="[{oxmultilang ident="EMAIL"}]" required>
        <label for="email">[{oxmultilang ident="EMAIL"}]</label>
        <div class="invalid-feedback">[{oxmultilang ident="DD_FORM_VALIDATION_VALIDEMAIL"}]</div>
    </div>

    [{block name="captcha_form"}][{if method_exists($oViewConf, 'getCaptchaWidget')}][{$oViewConf->getCaptchaWidget('pricealarm')}][{/if}][{/block}]

    <button class="btn btn-primary" type="submit">[{oxmultilang ident="SEND"}]</button>

</form>