[{block name="user_checkout_change"}]

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

    <form action="[{$oViewConf->getSslSelfLink()}]" name="order" method="post" class="user needs-validation" novalidate>
        [{block name="user_checkout_change_form"}]
            [{assign var="aErrors" value=$oView->getFieldValidationErrors()}]
            [{$oViewConf->getHiddenSid()}]
            [{$oViewConf->getNavFormParams()}]
            <input type="hidden" name="cl" value="user">
            <input type="hidden" name="option" value="[{$oView->getLoginOption()}]">
            <input type="hidden" name="fnc" value="changeuser">
            <input type="hidden" name="lgn_cook" value="0">
            <input type="hidden" name="blshowshipaddress" value="1">

            [{* ordering steps *}]
            [{include file="page/checkout/inc/steps.tpl" active=2}]

            [{block name="user_checkout_change_next_step_top"}]
            [{/block}]

            <div class="user__billingaddress mb-5">
                [{block name="user_checkout_billing"}]

                    [{block name="user_checkout_billing_head"}]
                        <h3 class="title-small">
                            [{oxmultilang ident="BILLING_ADDRESS"}]
                            <button type="button" class="btn btn-edit" data-bs-toggle="collapse" data-bs-target="#user__billingaddress-address, #user__billingaddress-form" aria-controls="user__billingaddress-address, user__billingaddress-form">
                                [{oxmultilang ident="CHANGE"}]
                            </button>
                        </h3>
                        [{*oxscript add="$('#userChangeAddress').click( function() { $('#addressForm').show();$('#addressText').hide();$('#userChangeAddress').hide();return false;});"*}]
                    [{/block}]

                [{/block}]

                [{block name="user_checkout_billing_feedback"}]
                    [{include file="widget/address/billing_address.tpl" noFormSubmit=true blSubscribeNews=true blOrderRemark=true collapse="user__billingaddress-address"}]
                [{/block}]

                [{block name="user_checkout_billing_form"}]
                    <div id="user__billingaddress-form" class="user__billingaddress-form collapse">
                        [{if not $oxcmp_user->oxuser__oxpassword->value}]
                            [{include file="form/fieldset/user_email.tpl"}]
                        [{/if}]
                        [{include file="form/fieldset/user_billing.tpl" noFormSubmit=true blSubscribeNews=true blOrderRemark=true}]
                    </div>
                [{/block}]
            </div>

            <div class="user__shippingaddress mb-5">
                [{block name="user_checkout_shipping"}]

                    [{block name="user_checkout_shipping_head"}]
                        <h3 class="title-small">
                            [{oxmultilang ident="SHIPPING_ADDRESS"}]
                            [{*if $oView->showShipAddress() and $oxcmp_user->getSelectedAddress()}]
                                <button class="btn btn-edit" name="changeShippingAddress" [{if !$oView->showShipAddress() and $oxcmp_user->getSelectedAddress()}] style="display: none;" [{/if}] title="[{oxmultilang ident="CHANGE"}]">
                                    [{oxmultilang ident="CHANGE"}]
                                </button>
                            [{/if*}]
                        </h3>
                    [{*oxscript add="$('#userChangeShippingAddress').toggle($(this).is(':not(:checked)'));"*}]
                    [{/block}]

                [{/block}]

                [{block name="user_checkout_shipping_change"}]
                    <div class="form-check">
                        <input data-bs-toggle="collapse" data-bs-target="#user__shippingaddress-change" class="form-check-input" type="checkbox" name="blshowshipaddress" value="0" id="user__shippingaddress-chance"[{if !$oView->showShipAddress()}] checked[{/if}] aria-controls="user__shippingaddress-change">
                        <label class="form-check-label" for="user__shippingaddress-chance">
                            [{oxmultilang ident="USE_BILLINGADDRESS_FOR_SHIPPINGADDRESS"}]
                        </label>
                    </div>
                [{/block}]

                [{block name="user_checkout_shipping_form"}]
                    <div id="user__shippingaddress-change" class="user__shippingaddress-change collapse[{if $oView->showShipAddress()}] show[{/if}]">
                        [{include file="form/fieldset/user_shipping.tpl" noFormSubmit=true onChangeClass='user'}]
                    </div>
                [{/block}]
            </div>

            [{block name="user_checkout_shipping_feedback"}]
                [{include file="form/fieldset/order_newsletter.tpl" blSubscribeNews=true}]
                [{include file="form/fieldset/order_remark.tpl" blOrderRemark=true}]
            [{/block}]

            [{block name="checkout_basketcontents_summary"}]
                <div class="basket__summary">

                    <div class="basket__summary-title">[{oxmultilang ident="O3_ORDER_SUMMARY"}]</div>

                    [{*  basket summary  *}]
                    <table class="table table-borderless">
                        [{block name="checkout_basketcontents_summary_table_inner"}]
                            [{if !$oxcmp_basket->getDiscounts()}]
                                [{block name="checkout_basketcontents_nodiscounttotalnet"}]
                                    <tr>
                                        <th>[{oxmultilang ident="TOTAL_NET"}]</th>
                                        <td id="basketTotalProductsNetto" class="text-end">[{oxprice price=$oxcmp_basket->getNettoSum() currency=$currency}]</td>
                                    </tr>
                                [{/block}]

                                [{block name="checkout_basketcontents_nodiscountproductvats"}]
                                    [{foreach from=$oxcmp_basket->getProductVats(false) item=VATitem key=key}]
                                        <tr>
                                            <th>[{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$key}]</th>
                                            <td class="text-end">[{oxprice price=$VATitem currency=$currency}]</td>
                                        </tr>
                                    [{/foreach}]
                                [{/block}]

                                [{block name="checkout_basketcontents_nodiscounttotalgross"}]
                                    <tr>
                                        <th>[{oxmultilang ident="TOTAL_GROSS" suffix="COLON"}]</th>
                                        <td id="basketTotalProductsGross" class="text-end">[{oxprice price=$oxcmp_basket->getBruttoSum() currency=$currency}]</td>
                                    </tr>
                                [{/block}]
                            [{else}]
                                [{if $oxcmp_basket->isPriceViewModeNetto()}]
                                    [{block name="checkout_basketcontents_discounttotalnet"}]
                                        <tr>
                                            <th>[{oxmultilang ident="TOTAL_NET"}]</th>
                                            <td id="basketTotalProductsNetto" class="text-end">[{oxprice price=$oxcmp_basket->getNettoSum() currency=$currency}]</td>
                                        </tr>
                                    [{/block}]
                                [{else}]
                                    [{block name="checkout_basketcontents_discounttotalgross"}]
                                        <tr>
                                            <th>[{oxmultilang ident="TOTAL_GROSS" suffix="COLON"}]</th>
                                            <td id="basketTotalProductsGross" class="text-end">[{oxprice price=$oxcmp_basket->getBruttoSum() currency=$currency}]</td>
                                        </tr>
                                    [{/block}]
                                [{/if}]

                                [{block name="checkout_basketcontents_discounts"}]
                                    [{foreach from=$oxcmp_basket->getDiscounts() item=oDiscount name=test_Discounts}]
                                        <tr>
                                            <th>
                                                [{if $oDiscount->dDiscount < 0}]
                                                [{oxmultilang ident="SURCHARGE"}]
                                                [{else}]
                                                [{oxmultilang ident="DISCOUNT"}]
                                                [{/if}]
                                                [{$oDiscount->sDiscount}]
                                            </th>
                                            <td class="text-end text-primary">
                                                [{oxprice price=$oDiscount->dDiscount*-1 currency=$currency}]
                                            </td>
                                        </tr>
                                    [{/foreach}]
                                [{/block}]

                                [{if !$oxcmp_basket->isPriceViewModeNetto()}]
                                    [{block name="checkout_basketcontents_totalnet"}]
                                        <tr>
                                            <th>[{oxmultilang ident="TOTAL_NET"}]</th>
                                            <td id="basketTotalNetto" class="text-end">[{oxprice price=$oxcmp_basket->getNettoSum() currency=$currency}]</td>
                                        </tr>
                                    [{/block}]
                                [{/if}]

                                [{block name="checkout_basketcontents_productvats"}]
                                    [{foreach from=$oxcmp_basket->getProductVats(false) item=VATitem key=key}]
                                        <tr>
                                            <th>[{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$key}]</th>
                                            <td class="text-end">[{oxprice price=$VATitem currency=$currency}]</td>
                                        </tr>
                                    [{/foreach}]
                                [{/block}]

                                [{if $oxcmp_basket->isPriceViewModeNetto()}]
                                    [{block name="checkout_basketcontents_totalgross"}]
                                        <tr>
                                            <th>[{oxmultilang ident="TOTAL_GROSS" suffix="COLON"}]</th>
                                            <td id="basketTotalGross" class="text-end">[{oxprice price=$oxcmp_basket->getBruttoSum() currency=$currency}]</td>
                                        </tr>
                                    [{/block}]
                                [{/if}]
                            [{/if}]
                        [{/block}]

                        [{block name="checkout_basketcontents_voucherdiscount"}]
                            [{if $oViewConf->getShowVouchers() && $oxcmp_basket->getVoucherDiscValue()}]
                                [{foreach from=$oxcmp_basket->getVouchers() item=sVoucher key=key name=Voucher}]
                                    <tr class="couponData">
                                        <th><span class="lead">[{oxmultilang ident="COUPON"}]&nbsp;([{oxmultilang ident="NUMBER"}] [{$sVoucher->sVoucherNr}])</span>
                                            [{if $editable}]
                                                <a href="[{$oViewConf->getSelfLink()}]&amp;cl=basket&amp;fnc=removeVoucher&amp;voucherId=[{$sVoucher->sVoucherId}]&amp;CustomError=basket&amp;stoken=[{$oViewConf->getSessionChallengeToken()}]" class="removeFn">[{oxmultilang ident="REMOVE"}]</a>
                                            [{/if}]
                                        </th>
                                        <td class="lead text-end">[{oxprice price=$sVoucher->dVoucherdiscount*-1 currency=$currency}]</td>
                                    </tr>
                                [{/foreach}]
                            [{/if}]
                        [{/block}]

                        [{block name="checkout_basketcontents_delcosts"}]
                            [{assign var="deliveryCost" value=$oxcmp_basket->getDeliveryCost()}]
                            [{if $deliveryCost && ($oxcmp_basket->getBasketUser() || $oViewConf->isFunctionalityEnabled('blCalculateDelCostIfNotLoggedIn') ) }]
                                [{if $oViewConf->isFunctionalityEnabled('blShowVATForDelivery') }]
                                    <tr>
                                        <th>[{ oxmultilang ident="SHIPPING_NET" suffix="COLON" }]</th>
                                        <td id="basketDeliveryNetto" class="text-end">[{oxprice price=$deliveryCost->getNettoPrice() currency=$currency }]</td>
                                    </tr>
                                    [{if $deliveryCost->getVatValue()}]
                                        <tr>
                                            [{if $oxcmp_basket->isProportionalCalculationOn() }]
                                                <th>[{oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON"}]</th>
                                            [{else}]
                                                <th>[{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$deliveryCost->getVat()}]</th>
                                            [{/if}]
                                            <td id="basketDeliveryVat" class="text-end">[{oxprice price=$deliveryCost->getVatValue() currency=$currency}]</td>
                                        </tr>
                                    [{/if}]
                                [{else}]
                                    <tr>
                                        <th>[{ oxmultilang ident="SHIPPING_COST" suffix="COLON" }]</th>
                                        <td id="basketDeliveryGross" class="text-end">[{oxprice price=$deliveryCost->getBruttoPrice() currency=$currency}]</td>
                                    </tr>
                                [{/if}]
                            [{/if}]
                        [{/block}]

                        [{block name="checkout_basketcontents_paymentcosts"}]
                            [{assign var="paymentCost" value=$oxcmp_basket->getPaymentCost()}]
                            [{if $paymentCost && $paymentCost->getPrice() }]
                                [{if $oViewConf->isFunctionalityEnabled('blShowVATForPayCharge') }]
                                    <tr>
                                        <th>[{if $paymentCost->getPrice() >= 0}][{ oxmultilang ident="SURCHARGE" }][{else}][{ oxmultilang ident="DEDUCTION" }][{/if}] [{ oxmultilang ident="PAYMENT_METHOD" suffix="COLON"}]</th>
                                        <td id="basketPaymentNetto">[{oxprice price=$paymentCost->getNettoPrice() currency=$currency }]</td>
                                    </tr>
                                    [{if $paymentCost->getVatValue()}]
                                        <tr>
                                            [{if $oxcmp_basket->isProportionalCalculationOn() }]
                                                <th>[{ oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON" }]</th>
                                            [{else}]
                                                <th>[{ oxmultilang ident="SURCHARGE_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$paymentCost->getVat() }]</th>
                                            [{/if}]
                                            <td id="basketPaymentVat">[{oxprice price=$paymentCost->getVatValue() currency=$currency }]</td>
                                        </tr>
                                    [{/if}]
                                [{else}]
                                    <tr>
                                        <th>[{if $paymentCost->getPrice() >= 0}][{ oxmultilang ident="SURCHARGE" }][{else}][{ oxmultilang ident="DEDUCTION" }][{/if}] [{ oxmultilang ident="PAYMENT_METHOD" suffix="COLON" }]</th>
                                        <td id="basketPaymentGross" class="text-end">[{oxprice price=$paymentCost->getBruttoPrice() currency=$currency }]</td>
                                    </tr>
                                [{/if}]
                            [{/if}]
                        [{/block}]

                        [{block name="checkout_basketcontents_wrappingcosts"}]
                            [{if $oViewConf->getShowGiftWrapping() }]

                                [{assign var="wrappingCost" value=$oxcmp_basket->getWrappingCost()}]
                                [{if $wrappingCost && $wrappingCost->getPrice() > 0 }]
                                    [{if $oViewConf->isFunctionalityEnabled('blShowVATForWrapping') }]
                                        <tr>
                                            <th>[{ oxmultilang ident="BASKET_TOTAL_WRAPPING_COSTS_NET" suffix="COLON" }]</th>
                                            <td id="basketWrappingNetto" class="text-end">[{oxprice price=$wrappingCost->getNettoPrice() currency=$currency}]</td>
                                        </tr>
                                        [{if $oxcmp_basket->getWrappCostVat() }]
                                            <tr>
                                                <th>[{ oxmultilang ident="PLUS_VAT" suffix="COLON" }]</th>
                                                <td id="basketWrappingVat" class="text-end">[{oxprice price=$wrappingCost->getVatValue() currency=$currency}]</td>
                                            </tr>
                                        [{/if}]
                                    [{else}]
                                        <tr>
                                            <th>[{ oxmultilang ident="GIFT_WRAPPING" suffix="COLON" }]</th>
                                            <td id="basketWrappingGross" class="text-end">[{oxprice price=$wrappingCost->getBruttoPrice() currency=$currency }]</td>
                                        </tr>
                                    [{/if}]
                                [{/if}]

                                [{assign var="giftCardCost" value=$oxcmp_basket->getGiftCardCost()}]
                                [{if $giftCardCost && $giftCardCost->getPrice() > 0 }]
                                    [{if $oViewConf->isFunctionalityEnabled('blShowVATForWrapping') }]
                                        <tr>
                                            <th>[{ oxmultilang ident="BASKET_TOTAL_GIFTCARD_COSTS_NET" suffix="COLON" }]</th>
                                            <td id="basketGiftCardNetto" class="text-end">[{oxprice price=$giftCardCost->getNettoPrice() currency=$currency }]</td>
                                        </tr>
                                        <tr>
                                            [{if $oxcmp_basket->isProportionalCalculationOn() }]
                                                <th>[{ oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON" }]</th>
                                            [{else}]
                                                <th>[{ oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$giftCardCost->getVat() }] </th>
                                            [{/if}]
                                            <td id="basketGiftCardVat" class="text-end">[{oxprice price=$giftCardCost->getVatValue() currency=$currency}]</td>
                                        </tr>
                                    [{else}]
                                        <tr>
                                            <th>[{ oxmultilang ident="GREETING_CARD" suffix="COLON" }]</th>
                                            <td id="basketGiftCardGross" class="text-end">[{oxprice price=$giftCardCost->getBruttoPrice() currency=$currency}]</td>
                                        </tr>
                                    [{/if}]
                                [{/if}]
                            [{/if}]
                        [{/block}]

                        [{block name="checkout_basketcontents_grandtotal"}]
                            <tr class="basket__summary-total">
                                <th class="lead">[{oxmultilang ident="GRAND_TOTAL" suffix="COLON"}]</th>
                                <td class="lead text-primary text-end">[{oxprice price=$oxcmp_basket->getPrice() currency=$currency}]</td>
                            </tr>
                        [{/block}]

                        [{if $oxcmp_basket->hasSkipedDiscount()}]
                            <tr>
                                <th><span class="note">**</span> [{oxmultilang ident="MESSAGE_COUPON_NOT_APPLIED_FOR_ARTICLES"}]</span></th>
                                <td></td>
                            </tr>
                        [{/if}]
                    </table>
                </div>
            [{/block}]

            <div class="user__navi">
                [{block name="user_checkout_change_next_step_bottom"}]
                    <a href="[{oxgetseourl ident=$oViewConf->getBasketLink()}]" class="btn btn-lg text-primary">
                        <svg width="16" height="13" viewBox="0 0 16 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M0.469669 5.96967C0.176776 6.26256 0.176776 6.73744 0.469669 7.03033L5.24264 11.8033C5.53553 12.0962 6.01041 12.0962 6.3033 11.8033C6.59619 11.5104 6.59619 11.0355 6.3033 10.7426L2.06066 6.5L6.3033 2.25736C6.59619 1.96447 6.59619 1.48959 6.3033 1.1967C6.01041 0.903806 5.53553 0.903806 5.24264 1.1967L0.469669 5.96967ZM16 5.75L0.999999 5.75V7.25L16 7.25V5.75Z" fill="currentColor"/>
                        </svg>
                        [{oxmultilang ident="PREVIOUS_STEP"}]
                    </a>

                    <button class="btn btn-primary btn-lg" name="userform" type="submit">
                        [{oxmultilang ident="NEXT"}]
                        <svg width="16" height="13" viewBox="0 0 16 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M15.5303 5.96967C15.8232 6.26256 15.8232 6.73744 15.5303 7.03033L10.7574 11.8033C10.4645 12.0962 9.98959 12.0962 9.6967 11.8033C9.40381 11.5104 9.40381 11.0355 9.6967 10.7426L13.9393 6.5L9.6967 2.25736C9.40381 1.96447 9.40381 1.48959 9.6967 1.1967C9.98959 0.903806 10.4645 0.903806 10.7574 1.1967L15.5303 5.96967ZM0 5.75L15 5.75V7.25L0 7.25L0 5.75Z" fill="white"/>
                        </svg>
                    </button>
                [{/block}]
            </div>
        [{/block}]
    </form>
    [{include file="form/fieldset/delete_shipping_address_modal.tpl"}]
[{/block}]
