[{assign var="aErrors" value=$oView->getFieldValidationErrors()}]

[{block name="user_checkout_noregistration"}]

    [{if $oxcmp_shop->oxshops__oxproductive->value}]
        [{oxscript include="js/widget/shippingaddress.min.js" priority=10}]
    [{else}]
        [{oxscript include="js/widget/shippingaddress.js" priority=10}]
    [{/if}]

    [{if $oxcmp_shop->oxshops__oxproductive->value}]
        [{oxscript include="js/widget/validate.min.js" priority=10}]
    [{else}]
        [{oxscript include="js/widget/validate.js" priority=10}]
    [{/if}]

    <form action="[{$oViewConf->getSslSelfLink()}]" name="order" method="post" class="needs-validation" novalidate>
        [{block name="user_checkout_noregistration_form"}]
            <div class="d-none">
                [{$oViewConf->getHiddenSid()}]
                [{$oViewConf->getNavFormParams()}]
                <input type="hidden" name="cl" value="user">
                <input type="hidden" name="option" value="1">
                [{if !$oxcmp_user->oxuser__oxpassword->value}]
                    <input type="hidden" name="fnc" value="createuser">
                [{else}]
                    <input type="hidden" name="fnc" value="changeuser">
                    <input type="hidden" name="lgn_cook" value="0">
                [{/if}]
                <input type="hidden" id="reloadAddress" name="reloadaddress" value="">
                <input type="hidden" name="blshowshipaddress" value="1">
            </div>

            [{block name="user_checkout_noregistration_next_step_top"}]
            [{/block}]

            <div class="row">

                <div class="col-12 col-md-5 mb-5">
                    <h3 class="title-small">[{oxmultilang ident="NOTREGISTERED_ACCOUNTINFO"}]</h3>
                    [{include file="form/fieldset/user_noaccount.tpl"}]
                </div>

                <div class="col-12 offset-md-2 col-md-5 mb-5">
                    <h3 class="title-small">[{oxmultilang ident="BILLING_ADDRESS"}]</h3>
                    [{include file="form/fieldset/user_billing.tpl" noFormSubmit=true blOrderRemark=true}]
                </div>

                <div class="col-12 offset-md-7 col-md-5 mb-5">

                    <h3 class="title-small">[{oxmultilang ident="SHIPPING_ADDRESS"}]</h3>

                    [{block name="user_checkout_noregistration_shipping_address_body"}]

                        <div class="form-check">
                            <input data-bs-toggle="collapse" data-bs-target="#user__shippingaddress-change" class="form-check-input" type="checkbox" name="blshowshipaddress" value="0" id="user__shippingaddress-chance"[{if !$oView->showShipAddress()}] checked[{/if}] aria-controls="user__shippingaddress-change">
                            <label class="form-check-label" for="user__shippingaddress-chance">
                                [{oxmultilang ident="USE_BILLINGADDRESS_FOR_SHIPPINGADDRESS"}]
                            </label>
                        </div>

                        <div id="user__shippingaddress-change" class="user__shippingaddress-change collapse[{if $oView->showShipAddress()}] show[{/if}]">
                            [{include file="form/fieldset/user_shipping.tpl" noFormSubmit=true}]
                        </div>

                    [{/block}]

                </div>

                <div class="col-12 offset-md-7 col-md-5">
                    [{include file="form/fieldset/order_remark.tpl" blOrderRemark=true}]
                </div>
            </div>

            [{block name="user_checkout_noregistration_next_step_bottom"}]
                <div class="user__navi">
                    <a href="[{oxgetseourl ident=$oViewConf->getBasketLink()}]" class="btn btn-lg text-primary">
                        <svg width="16" height="13" viewBox="0 0 16 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M0.469669 5.96967C0.176776 6.26256 0.176776 6.73744 0.469669 7.03033L5.24264 11.8033C5.53553 12.0962 6.01041 12.0962 6.3033 11.8033C6.59619 11.5104 6.59619 11.0355 6.3033 10.7426L2.06066 6.5L6.3033 2.25736C6.59619 1.96447 6.59619 1.48959 6.3033 1.1967C6.01041 0.903806 5.53553 0.903806 5.24264 1.1967L0.469669 5.96967ZM16 5.75L0.999999 5.75V7.25L16 7.25V5.75Z" fill="currentColor"/>
                        </svg>
                        [{oxmultilang ident="PREVIOUS_STEP"}]
                    </a>
                    <button class="btn btn-primary btn-lg" name="userform" type="submit">
                        [{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}]
                    </button>
                </div>
            [{/block}]
        [{/block}]
    </form>
    [{include file="form/fieldset/delete_shipping_address_modal.tpl"}]
[{/block}]
