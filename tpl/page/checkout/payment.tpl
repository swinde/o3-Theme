[{capture append="oxidBlock_content"}]

    <h1 class="title-big">
        [{oxmultilang ident="O3_CHECKOUT"}]
    </h1>

    <hr class="hr-big">

    <div class="payment">
        [{include file="page/checkout/inc/steps.tpl" active=3}]

        [{block name="checkout_payment_main"}]
            [{assign var="currency" value=$oView->getActCurrency()}]
            [{block name="change_shipping"}]
                [{if $oView->getAllSets()}]
                    [{assign var="aErrors" value=$oView->getFieldValidationErrors()}]
                    <form class="payment__delivery" action="[{$oViewConf->getSslSelfLink()}]" name="shipping" method="post">
                        <div class="d-none">
                            [{$oViewConf->getHiddenSid()}]
                            [{$oViewConf->getNavFormParams()}]
                            <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
                            <input type="hidden" name="fnc" value="changeshipping">
                        </div>

                        [{block name="act_shipping"}]

                            <h3 class="title-small">
                                [{if $oView->getAllSetsCnt() > 1}][{oxmultilang ident="SHIPPING"}][{else}][{oxmultilang ident="SELECTED_SHIPPING_CARRIER"}][{/if}]
                                [{assign var="oDeliveryCostPrice" value=$oxcmp_basket->getDeliveryCost()}]
                                [{if $oDeliveryCostPrice && $oDeliveryCostPrice->getPrice() > 0}]
                                    [{if $oViewConf->isFunctionalityEnabled('blShowVATForDelivery') }]
                                        <span>
                                            [{oxmultilang ident="CHARGES" suffix="COLON"}] [{oxprice price=$oDeliveryCostPrice->getNettoPrice() currency=$currency}]
                                            ([{oxmultilang ident="PLUS_VAT"}] [{oxprice price=$oDeliveryCostPrice->getVatValue() currency=$currency}])
                                        </span>
                                    [{else}]
                                        <span>[{oxmultilang ident="CHARGES" suffix="COLON"}] [{oxprice price=$oDeliveryCostPrice->getBruttoPrice() currency=$currency}]</span>
                                    [{/if}]
                                [{else}]
                                    <span>[{oxmultilang ident="CHARGES" suffix="COLON"}] [{oxprice price="0.00" currency=$currency}]</span>
                                [{/if}]
                            </h3>

                            [{foreach key=sShipID from=$oView->getAllSets() item=oShippingSet name=ShipSetSelect}]
                                <div class="form-check">
                                    <input value="[{$sShipID}]" class="form-check-input" type="radio" name="sShipSet" id="[{$sShipID}]" [{if $oShippingSet->blSelected}]checked[{/if}] onchange="this.form.submit();">
                                    <label class="form-check-label" for="[{$sShipID}]">
                                        <span>[{$oShippingSet->oxdeliveryset__oxtitle->value}]</span>
                                    </label>
                                </div>
                            [{/foreach}]

                            <noscript>
                                <button type="submit" class="btn btn-success">[{oxmultilang ident="UPDATE_SHIPPING_CARRIER"}]</button>
                            </noscript>
                        [{/block}]

                    </form>
                [{/if}]
            [{/block}]

            [{block name="checkout_payment_errors"}]
                [{assign var="iPayError" value=$oView->getPaymentError()}]

                [{if $iPayError == 1}]
                    <div class="alert alert-danger">[{oxmultilang ident="ERROR_MESSAGE_COMPLETE_FIELDS_CORRECTLY"}]</div>
                [{elseif $iPayError == 2}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_AUTHORIZATION_FAILED"}]</div>
                [{elseif $iPayError == 4}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_UNAVAILABLE_SHIPPING_METHOD"}]</div>
                [{elseif $iPayError == 5}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_AUTHORIZATION_FAILED"}]</div>
                [{elseif $iPayError >= 6}]
                    <!--Add custom error message here-->
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_AUTHORIZATION_FAILED"}]</div>
                [{elseif $iPayError == -1}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_UNAVAILABLE_PAYMENT_ERROR"}] "[{$oView->getPaymentErrorText()}]").</div>
                [{elseif $iPayError == -2}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_NO_SHIPPING_METHOD_FOUND"}]</div>
                [{elseif $iPayError == -3}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_SELECT_ANOTHER_PAYMENT"}]</div>
                [{elseif $iPayError == -4}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_BANK_CODE_INVALID"}]</div>
                [{elseif $iPayError == -5}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_ACCOUNT_NUMBER_INVALID"}]</div>
                [{/if}]
            [{/block}]

            [{block name="change_payment"}]
                <form class="payment__payments" action="[{$oViewConf->getSslSelfLink()}]" name="order" method="post">
                    <div class="d-none">
                        [{$oViewConf->getHiddenSid()}]
                        [{$oViewConf->getNavFormParams()}]
                        <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
                        <input type="hidden" name="fnc" value="validatepayment">
                    </div>

                    [{if $oView->getPaymentList()}]

                        <h3 class="title-small">[{oxmultilang ident="PAYMENT_METHOD"}]</h3>

                        [{assign var="inptcounter" value="-1"}]
                        [{foreach key=sPaymentID from=$oView->getPaymentList() item=paymentmethod name=PaymentSelect}]
                            [{assign var="inptcounter" value="`$inptcounter+1`"}]
                            [{block name="select_payment"}]

                                [{if $sPaymentID == "oxidcashondel"}]
                                    [{include file="page/checkout/inc/payment_oxidcashondel.tpl"}]
                                [{elseif $sPaymentID == "oxidcreditcard"}]
                                    [{include file="page/checkout/inc/payment_oxidcreditcard.tpl"}]
                                [{elseif $sPaymentID == "oxiddebitnote"}]
                                    [{include file="page/checkout/inc/payment_oxiddebitnote.tpl"}]
                                [{else}]
                                    [{include file="page/checkout/inc/payment_other.tpl"}]
                                [{/if}]

                            [{/block}]
                        [{/foreach}]

                        [{block name="checkout_payment_nextstep"}]
                            [{if $oView->isLowOrderPrice()}]
                                <div class="alert alert-info">
                                    <b>[{oxmultilang ident="MIN_ORDER_PRICE"}] [{$oView->getMinOrderPrice()}] [{$currency->sign}]</b>
                                </div>
                            [{else}]
                                <div class="payment__navi">
                                    <a href="[{oxgetseourl ident=$oViewConf->getOrderLink()}]" class="btn btn-lg text-primary">
                                        <svg width="16" height="13" viewBox="0 0 16 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M0.469669 5.96967C0.176776 6.26256 0.176776 6.73744 0.469669 7.03033L5.24264 11.8033C5.53553 12.0962 6.01041 12.0962 6.3033 11.8033C6.59619 11.5104 6.59619 11.0355 6.3033 10.7426L2.06066 6.5L6.3033 2.25736C6.59619 1.96447 6.59619 1.48959 6.3033 1.1967C6.01041 0.903806 5.53553 0.903806 5.24264 1.1967L0.469669 5.96967ZM16 5.75L0.999999 5.75V7.25L16 7.25V5.75Z" fill="currentColor"/>
                                        </svg>
                                        [{oxmultilang ident="PREVIOUS_STEP"}]
                                    </a>
                                    <button type="submit" name="userform" class="btn btn-primary btn-lg">
                                        [{oxmultilang ident="NEXT"}]
                                        <svg width="16" height="13" viewBox="0 0 16 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M15.5303 5.96967C15.8232 6.26256 15.8232 6.73744 15.5303 7.03033L10.7574 11.8033C10.4645 12.0962 9.98959 12.0962 9.6967 11.8033C9.40381 11.5104 9.40381 11.0355 9.6967 10.7426L13.9393 6.5L9.6967 2.25736C9.40381 1.96447 9.40381 1.48959 9.6967 1.1967C9.98959 0.903806 10.4645 0.903806 10.7574 1.1967L15.5303 5.96967ZM0 5.75L15 5.75V7.25L0 7.25L0 5.75Z" fill="white"/>
                                        </svg>
                                    </button>
                                </div>
                            [{/if}]
                        [{/block}]

                    [{elseif $oView->getEmptyPayment()}]
                        [{block name="checkout_payment_nopaymentsfound"}]
                            <div class="lineBlock"></div>
                            <h3 id="paymentHeader" class="blockHead">[{oxmultilang ident="PAYMENT_INFORMATION"}]</h3>
                            [{oxifcontent ident="oxnopaymentmethod" object="oCont"}]
                                [{$oCont->oxcontents__oxcontent->value}]
                            [{/oxifcontent}]
                            <input type="hidden" name="paymentid" value="oxempty">
                            <div class="lineBox clear">
                                <div class="card bg-light cart-buttons">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-12 col-md-6">
                                                <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=user"}]" class="btn btn-outline-dark float-left prevStep submitButton largeButton"><i class="fa fa-caret-left"></i> [{oxmultilang ident="PREVIOUS_STEP"}]</a>
                                            </div>
                                            <div class="col-12 col-md-6 text-right">
                                                <button type="submit" name="userform" class="btn btn-primary pull-right submitButton nextStep largeButton" id="paymentNextStepBottom">[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}] <i class="fa fa-caret-right"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        [{/block}]
                    [{/if}]
                </form>
            [{/block}]
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
    </div>
    [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]

[{include file="layout/page.tpl" blHideBreadcrumb=true}]
