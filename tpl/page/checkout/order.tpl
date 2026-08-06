[{capture append="oxidBlock_content"}]

    [{if $oxcmp_shop->oxshops__oxproductive->value}]
        [{oxscript include="js/widget/check-agb.min.js" priority=10}]
    [{else}]
        [{oxscript include="js/widget/check-agb.js" priority=10}]
    [{/if}]

    <h1 class="title-big">
        [{oxmultilang ident="O3_CHECKOUT"}]
    </h1>

    <hr class="hr-big">

    [{block name="checkout_order_errors"}]
        [{if $oView->isConfirmAGBActive() && $oView->isConfirmAGBError() == 1}]
            [{include file="message/error.tpl" statusMessage="READ_AND_CONFIRM_TERMS"|oxmultilangassign}]
        [{/if}]
        [{assign var="iError" value=$oView->getAddressError()}]
        [{if $iError == 1}]
           [{include file="message/error.tpl" statusMessage="ERROR_DELIVERY_ADDRESS_WAS_CHANGED_DURING_CHECKOUT"|oxmultilangassign}]
        [{/if}]
    [{/block}]

    <div class="order">

        [{* ordering steps *}]
        [{include file="page/checkout/inc/steps.tpl" active=4}]

        [{block name="checkout_order_main"}]

            [{block name="checkout_order_details"}]
                [{if !$oxcmp_basket->getProductsCount() }]
                    [{block name="checkout_order_emptyshippingcart"}]
                        <div class="alert alert-danger">[{oxmultilang ident="BASKET_EMPTY"}]</div>
                    [{/block}]
                [{else}]
                    [{assign var="currency" value=$oView->getActCurrency()}]

                    [{block name="checkout_order_next_step_top"}]
                        [{if $oView->isLowOrderPrice()}]
                            [{block name="checkout_order_loworderprice_top"}]
                                <div class="alert alert-info">[{oxmultilang ident="MIN_ORDER_PRICE"}] [{$oView->getMinOrderPrice()}] [{$currency->sign}]</div>
                            [{/block}]
                        [{/if}]
                    [{/block}]

                    [{block name="checkout_order_vouchers"}]
                        [{if $oViewConf->getShowVouchers() && $oxcmp_basket->getVouchers()}]
                            [{oxmultilang ident="USED_COUPONS"}]
                            [{foreach from=$Errors.basket item=oEr key=key}]
                                [{if $oEr->getErrorClassType() == 'oxVoucherException'}]
                                    <div class="alert alert-danger">
                                        [{oxmultilang ident="PAGE_CHECKOUT_ORDER_COUPONNOTACCEPTED1"}] [{$oEr->getValue('voucherNr')}] [{oxmultilang ident="PAGE_CHECKOUT_ORDER_COUPONNOTACCEPTED2"}]<br>
                                        [{oxmultilang ident="REASON"}]
                                        [{$oEr->getOxMessage()}]
                                    </div>
                                [{/if}]
                            [{/foreach}]
                            <div class="alert alert-info">
                                [{foreach from=$oxcmp_basket->getVouchers() item=sVoucher key=key name=aVouchers}]
                                    [{$sVoucher->sVoucherNr}]<br>
                                [{/foreach}]
                            </div>
                        [{/if}]
                    [{/block}]

                    [{block name="checkout_order_address"}]
                        <form action="[{$oViewConf->getSslSelfLink()}]" method="post" class="order__billingaddress">
                            <div class="d-none">
                                [{$oViewConf->getHiddenSid()}]
                                <input type="hidden" name="cl" value="user">
                                <input type="hidden" name="fnc" value="">
                            </div>

                            <h3 class="title-small">
                                [{oxmultilang ident="BILLING_ADDRESS"}]
                                <button type="submit" class="btn btn-edit" title="[{oxmultilang ident="EDIT"}]">
                                    [{oxmultilang ident="EDIT"}]
                                </button>
                            </h3>

                            [{include file="widget/address/billing_address.tpl"}]
                        </form>

                        <form action="[{$oViewConf->getSslSelfLink()}]" method="post" class="order__shippingaddress">
                            <div class="d-none">
                                [{$oViewConf->getHiddenSid()}]
                                <input type="hidden" name="cl" value="user">
                                <input type="hidden" name="fnc" value="">
                            </div>

                            <h3 class="title-small">
                                [{oxmultilang ident="SHIPPING_ADDRESS"}]
                                <button type="submit" class="btn btn-edit" title="[{oxmultilang ident="EDIT"}]">
                                    [{oxmultilang ident="EDIT"}]
                                </button>
                            </h3>

                            [{block name="checkout_order_address_inner"}]
                                [{assign var="oDelAdress" value=$oView->getDelAddress()}]
                                [{if $oDelAdress}]
                                    [{include file="widget/address/shipping_address.tpl" delivadr=$oDelAdress}]
                                [{else}]
                                    [{include file="widget/address/billing_address.tpl"}]
                                [{/if}]
                            [{/block}]
                        </form>
                    [{/block}]

                    [{block name="shippingAndPayment"}]
                        <form action="[{$oViewConf->getSslSelfLink()}]" method="post" class="order__delivery">
                            <div class="d-none">
                                [{$oViewConf->getHiddenSid()}]
                                <input type="hidden" name="cl" value="payment">
                                <input type="hidden" name="fnc" value="">
                            </div>

                            <h3 class="title-small">
                                [{oxmultilang ident="SHIPPING_CARRIER"}]
                                <button type="submit" class="btn btn-edit" title="[{oxmultilang ident="EDIT"}]">
                                    [{oxmultilang ident="EDIT"}]
                                </button>
                            </h3>

                            [{assign var="oShipSet" value=$oView->getShipSet()}]
                            [{$oShipSet->oxdeliveryset__oxtitle->value}]
                        </form>

                        <form action="[{$oViewConf->getSslSelfLink()}]" method="post" class="order__payment">
                            <div class="d-none">
                                [{$oViewConf->getHiddenSid()}]
                                <input type="hidden" name="cl" value="payment">
                                <input type="hidden" name="fnc" value="">
                            </div>

                            <h3 class="title-small">
                                [{oxmultilang ident="PAYMENT_METHOD"}]
                                <button type="submit" class="btn btn-edit" title="[{oxmultilang ident="EDIT"}]">
                                    [{oxmultilang ident="EDIT"}]
                                </button>
                            </h3>

                            [{assign var="payment" value=$oView->getPayment()}]
                            [{$payment->oxpayments__oxdesc->value}]
                        </form>
                    [{/block}]

                    [{block name="checkout_order_remark"}]
                        [{if $oView->getOrderRemark()}]
                            <form action="[{$oViewConf->getSslSelfLink()}]" method="post" class="order__message">
                                <div class="d-none">
                                    [{$oViewConf->getHiddenSid()}]
                                    <input type="hidden" name="cl" value="user">
                                    <input type="hidden" name="fnc" value="">
                                </div>

                                <h3 class="title-small">
                                    [{oxmultilang ident="WHAT_I_WANTED_TO_SAY"}]
                                    <button type="submit" class="btn btn-edit" title="[{oxmultilang ident="EDIT"}]">
                                        [{oxmultilang ident="EDIT"}]
                                    </button>
                                </h3>

                                [{$oView->getOrderRemark()|@nl2br}]
                            </form>
                        [{/if}]
                    [{/block}]

                    <form action="[{$oViewConf->getSslSelfLink()}]" method="post" class="order__articles">
                        <div class="d-none">
                            [{$oViewConf->getHiddenSid()}]
                            <input type="hidden" name="cl" value="basket">
                            <input type="hidden" name="fnc" value="">
                        </div>

                        <h3 class="title-small">
                            [{oxmultilang ident="CART"}]
                            <button type="submit" class="btn btn-edit" title="[{oxmultilang ident="EDIT"}]">
                                [{oxmultilang ident="EDIT"}]
                            </button>
                        </h3>

                        [{block name="order_basket"}]
                            [{* Per-line EU durability-guarantee labels render inside each basket *}]
                            [{* row (basketcontents_list.tpl, #219) so multi-product baskets with *}]
                            [{* different durations each get their own label. *}]
                            [{include file="page/checkout/inc/basketcontents.tpl" editable=false}]
                        [{/block}]
                    </form>
                [{/if}]

                [{block name="checkout_order_agb"}]
                    [{if !$oView->isLowOrderPrice()}]

                        <form action="[{$oViewConf->getSslSelfLink()}]" method="post" class="order__agb" id="orderConfirmAgbTop">
                            [{$oViewConf->getHiddenSid()}]
                            [{$oViewConf->getNavFormParams()}]
                            <input type="hidden" name="cl" value="order">
                            <input type="hidden" name="fnc" value="[{$oView->getExecuteFnc()}]">
                            <input type="hidden" name="challenge" value="[{$challenge}]">
                            <input type="hidden" name="sDeliveryAddressMD5" value="[{$oView->getDeliveryAddressMD5()}]">

                            [{include file="page/checkout/inc/agb.tpl"}]
                        </form>
                    [{/if}]
                [{/block}]

                [{block name="checkout_order_next_step_bottom"}]
                    [{if $oView->isLowOrderPrice()}]
                        [{block name="checkout_order_loworderprice_bottom"}]
                            <div class="alert alert-info">
                                <div>[{oxmultilang ident="MIN_ORDER_PRICE"}] [{$oView->getMinOrderPrice()}] [{$currency->sign}]</div>
                            </div>
                        [{/block}]
                    [{else}]
                        [{block name="checkout_order_btn_confirm_bottom"}]
                            <form action="[{$oViewConf->getSslSelfLink()}]" method="post" class="order__navi">
                                <div class="d-none">
                                    [{$oViewConf->getHiddenSid()}]
                                    [{$oViewConf->getNavFormParams()}]
                                    <input type="hidden" name="cl" value="order">
                                    <input type="hidden" name="fnc" value="[{$oView->getExecuteFnc()}]">
                                    <input type="hidden" name="challenge" value="[{$challenge}]">
                                    <input type="hidden" name="sDeliveryAddressMD5" value="[{$oView->getDeliveryAddressMD5()}]">

                                    [{if $oView->isActive('PsLogin') || !$oView->isConfirmAGBActive()}]
                                        <input type="hidden" name="ord_agb" value="1">
                                    [{else}]
                                        <input type="hidden" name="ord_agb" value="0">
                                    [{/if}]
                                    <input type="hidden" name="oxdownloadableproductsagreement" value="0">
                                    <input type="hidden" name="oxserviceproductsagreement" value="0">
                                </div>

                                [{block name="checkout_order_btn_submit_bottom"}]
                                    <button type="submit" class="btn btn-primary btn-lg">
                                        [{oxmultilang ident="SUBMIT_ORDER"}]
                                    </button>
                                [{/block}]
                            </form>
                        [{/block}]
                    [{/if}]
                [{/block}]
            [{/block}]
        [{/block}]
    </div>
    [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]

[{assign var="template_title" value="REVIEW_YOUR_ORDER"|oxmultilangassign}]
[{include file="layout/page.tpl" title=$template_title location=$template_title blHideBreadcrumb=true}]
