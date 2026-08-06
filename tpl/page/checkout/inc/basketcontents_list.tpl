[{* basket items *}]
[{if !$editable}]
[{* #219 order-review cart line: tidy, vertically-aligned layout (title on its own line,
   Verpackung + compact guarantee label stacked left, stepper and price centered). *}]
<style>
.component__basketarticle:has(.o3-orderline){align-items:center;}
.o3-orderline{align-items:center;column-gap:2rem;row-gap:.4rem;}
.o3-orderline>.component__basketarticle-title{width:100%;margin-bottom:.1rem;}
.o3-orderline>.d-flex.flex-column{gap:2px;justify-content:space-between;align-self:stretch;}
.o3-orderline>.d-flex.flex-column .wrapping{line-height:1.1;margin-top:-.35rem;}
.o3-orderline .o3-guarantee--order{margin:0;line-height:0;}
.o3-orderline .o3-guarantee--order .o3-guarantee__summary{max-width:none;padding:0;line-height:0;}
.o3-orderline .o3-guarantee__banner{max-height:1.05rem;width:auto;display:block;}
.o3-orderline .component__basketarticle-price{align-self:center;}
</style>
[{/if}]
[{assign var="basketitemlist" value=$oView->getBasketArticles()}]
[{assign var="oConfig" value=$oViewConf->getConfig()}]
[{foreach key=basketindex from=$oxcmp_basket->getContents() item=basketitem name=basketContents}]
    [{block name="checkout_basketcontents_basketitem"}]
        [{assign var="basketproduct" value=$basketitemlist.$basketindex}]
        [{assign var="oArticle" value=$basketitem->getArticle()}]
        [{assign var="oAttributes" value=$oArticle->getAttributesDisplayableInBasket()}]

        <div class="component__basketarticle">

            [{block name="checkout_basketcontents_basketitem_image"}]
                [{* product image *}]
                [{if $editable}]
                    <a href="[{$basketitem->getLink()}]">
                        <img src="[{$basketitem->getIconUrl()}]" alt="[{$basketitem->getTitle()|strip_tags}]">
                    </a>
                [{else}]
                    <img src="[{$basketitem->getIconUrl()}]" alt="[{$basketitem->getTitle()|strip_tags}]">
                [{/if}]
            [{/block}]

            <div class="component__basketarticle-info[{if !$editable}] o3-orderline[{/if}]">
                [{block name="checkout_basketcontents_basketitem_titlenumber"}]
                    [{block name="checkout_basketcontents_basketitem_title"}]
                        [{if $editable}]
                            <a class="component__basketarticle-title" rel="nofllow" href="[{$basketitem->getLink()}]">
                                [{$basketitem->getTitle()}]
                            </a>
                        [{else}]
                            <div class="component__basketarticle-title">[{$basketitem->getTitle()}]</div>
                        [{/if}]
                        [{if $basketitem->isSkipDiscount()}] <sup><a href="#SkipDiscounts_link" >**</a></sup>[{/if}]
                    [{/block}]

                    [{block name="checkout_basketcontents_basketitem_removecheckbox"}]
                        [{if $editable}]
                            <input type="hidden" name="aproducts[[{$basketindex}]][remove]" value="0">
                            <button type="submit" name="removeBtn" class="component__basketarticle-remove btn" data-remove-id="aproducts[[{$basketindex}]][remove]" data-js="remove-from-basket">
                                <svg width="18" height="20" viewBox="0 0 18 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M5.4375 2.3125H5.25C5.35313 2.3125 5.4375 2.22812 5.4375 2.125V2.3125ZM5.4375 2.3125H12.5625V2.125C12.5625 2.22812 12.6469 2.3125 12.75 2.3125H12.5625V4H14.25V2.125C14.25 1.29766 13.5773 0.625 12.75 0.625H5.25C4.42266 0.625 3.75 1.29766 3.75 2.125V4H5.4375V2.3125ZM17.25 4H0.75C0.335156 4 0 4.33516 0 4.75V5.5C0 5.60313 0.084375 5.6875 0.1875 5.6875H1.60312L2.18203 17.9453C2.21953 18.7445 2.88047 19.375 3.67969 19.375H14.3203C15.1219 19.375 15.7805 18.7469 15.818 17.9453L16.3969 5.6875H17.8125C17.9156 5.6875 18 5.60313 18 5.5V4.75C18 4.33516 17.6648 4 17.25 4ZM14.1398 17.6875H3.86016L3.29297 5.6875H14.707L14.1398 17.6875Z" fill="#D4D4D4"/>
                                </svg>
                            </button>
                        [{/if}]
                    [{/block}]

                    [{*
                    <div class="component__basketarticle-details">
                        [{block name="checkout_basketcontents_basketitem_artnum"}]
                            <span>[{oxmultilang ident="PRODUCT_NO"}] [{$basketproduct->oxarticles__oxartnum->value}]</span>
                        [{/block}]

                        [{block name="checkout_basketcontents_basketitem_attributes"}]
                            [{assign var=sep value=", "}]
                            [{assign var=result value=""}]
                            [{foreach key="oArtAttributes" from=$oAttributes->getArray() item="oAttr" name="attributeContents"}]
                                [{assign var=temp value=$oAttr->oxattribute__oxvalue->value}]
                                [{assign var=result value=$result|cat:$temp|cat:$sep}]
                            [{/foreach}]
                            [{$result|trim:$sep}]
                        [{/block}]

                        [{block name="checkout_basketcontents_basketitem_selectlists"}]
                            [{if !$basketitem->isBundle() || !$basketitem->isDiscountArticle()}]
                                [{assign var="oSelections" value=$basketproduct->getSelections(null,$basketitem->getSelList())}]
                                [{if $oSelections}]
                                    <div class="selectorsBox clear" id="cartItemSelections_[{$smarty.foreach.basketContents.iteration}]">
                                        [{foreach from=$oSelections item=oList name=selections}]
                                            [{if $oViewConf->showSelectListsInList()}]
                                                [{include file="widget/product/selectbox.tpl" oSelectionList=$oList sFieldName="aproducts[`$basketindex`][sel]" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop"}]
                                            [{else}]
                                                [{assign var="oActiveSelection" value=$oList->getActiveSelection()}]
                                                [{if $oActiveSelection}]
                                                    <input type="hidden" name="aproducts[[{$basketindex}]][sel][[{$smarty.foreach.selections.index}]]" value="[{$oActiveSelection->getValue()}]">
                                                    <div>[{$oList->getLabel()}]: [{$oActiveSelection->getName()}]</div>
                                                [{/if}]
                                            [{/if}]
                                        [{/foreach}]
                                    </div>
                                [{/if}]
                            [{/if}]
                        [{/block}]

                        [{block name="checkout_basketcontents_basketitem_persparams"}]
                            [{if !$editable}]
                                <p class="persparamBox">
                                    [{foreach key=sVar from=$basketitem->getPersParams() item=aParam name=persparams}]
                                        [{if !$smarty.foreach.persparams.first}]<br />[{/if}]
                                        [{if $smarty.foreach.persparams.first && $smarty.foreach.persparams.last}]
                                            [{oxmultilang ident="LABEL"}]
                                        [{else}]
                                            [{$sVar}] :
                                        [{/if}]
                                        [{$aParam}]
                                    [{/foreach}]
                                </p>
                            [{else}]
                                [{if $basketproduct->oxarticles__oxisconfigurable->value}]
                                    [{if $basketitem->getPersParams()}]
                                        <br />
                                        [{foreach key=sVar from=$basketitem->getPersParams() item=aParam name=persparams}]
                                            <p>
                                                <input class="textbox persParam form-control" type="text" name="aproducts[[{$basketindex}]][persparam][[{$sVar}]]" value="[{$aParam}]" placeholder="[{if $smarty.foreach.persparams.first && $smarty.foreach.persparams.last}][{oxmultilang ident="LABEL"}][{else}][{$sVar}][{/if}]">
                                            </p>
                                        [{/foreach}]
                                    [{else}]
                                        <p>
                                            <input class="textbox persParam form-control" type="text" name="aproducts[[{$basketindex}]][persparam][details]" value="" placeholder="[{oxmultilang ident="LABEL"}]">
                                        </p>
                                    [{/if}]
                                [{/if}]
                            [{/if}]
                        [{/block}]

                        [{block name="checkout_basketcontents_basketitem_unitprice"}]
                            [{if $basketitem->getUnitPrice()}]
                                <span>[{oxmultilang ident="UNIT_PRICE"}]: [{oxprice price=$basketitem->getUnitPrice() currency=$currency}]</span>
                            [{/if}]
                        [{/block}]
                    </div>
                    *}]
                [{/block}]

                [{* Verpackung + guarantee label stacked, centered against the +/- stepper for flush alignment (#219). *}]
                <div class="d-flex flex-column">
                [{block name="checkout_basketcontents_basketitem_wrapping"}]
                    [{* product wrapping *}]
                    [{if $oView->isWrapping()}]
                        <div class="wrapping">
                            [{if !$basketitem->getWrappingId()}]
                                [{if $editable}]
                                    <a href="#" class="btn btn-outline-dark btn-sm" title="[{oxmultilang ident="ADD"}]" data-toggle="modal" data-target="#giftoptions">[{oxmultilang ident="WRAPPING"}] [{oxmultilang ident="ADD"}]</a>
                                [{else}]
                                    <small>[{oxmultilang ident="WRAPPING"}]: [{oxmultilang ident="NONE"}]</small>
                                [{/if}]
                            [{else}]
                                [{assign var="oWrap" value=$basketitem->getWrapping()}]
                                [{if $editable}]
                                    <small>[{oxmultilang ident="WRAPPING"}]:</small> <a class="btn btn-outline-dark btn-sm" href="#" title="[{oxmultilang ident="ADD"}]" data-toggle="modal" data-target="#giftoptions"><i class="fas fa-pencil-alt"></i> [{$oWrap->oxwrapping__oxname->value}]</a>
                                [{else}]
                                    <small>[{oxmultilang ident="WRAPPING"}]: [{$oWrap->oxwrapping__oxname->value}]</small>
                                [{/if}]
                            [{/if}]
                        </div>
                    [{/if}]
                [{/block}]

                [{* EU durability-guarantee label under the product info, left-aligned (#219): each *}]
                [{* eligible product carries its own label — a basket may mix different durations. *}]
                [{if !$editable}]
                    [{assign var="oGuaranteeArticle" value=$oArticle}]
                    [{assign var="sGuaranteeContext" value="o3-guarantee--order"}]
                    [{include file="page/details/inc/guaranteelabel.tpl"}]
                [{/if}]
                </div>[{* /Verpackung + label column *}]

                [{block name="checkout_basketcontents_basketitem_amount"}]
                    [{*
                    [{if $basketitem->getFUnitPrice()}] | [{/if}]
                    [{if $basketitem->oxarticles__oxunitname->value}]
                        [{$basketitem->getAmount()}] [{$basketitem->oxarticles__oxunitname->value}]
                    [{else}]
                        [{$basketitem->getAmount()}] [{oxmultilang ident="PCS"}]
                    [{/if}]
                    *}]
                [{/block}]

                [{block name="checkout_basketcontents_basketitem_vat"}]
                    [{*
                    [{$basketitem->getVatPercent()}]% [{oxmultilang ident="VAT"}]
                    *}]
                [{/block}]

                [{block name="checkout_basketcontents_basketitem_quantity"}]
                    [{* product quantity manager *}]

                    [{if $editable}]
                        <input type="hidden" name="aproducts[[{$basketindex}]][aid]" value="[{$basketitem->getProductId()}]">
                        <input type="hidden" name="aproducts[[{$basketindex}]][basketitemid]" value="[{$basketindex}]">
                        <input type="hidden" name="aproducts[[{$basketindex}]][override]" value="1">
                        [{if $basketitem->isBundle()}]
                            <input type="hidden" name="aproducts[[{$basketindex}]][bundle]" value="1">
                        [{/if}]

                        [{if !$basketitem->isBundle() || !$basketitem->isDiscountArticle()}]

                            [{assign var="tobasket_name" value="aproducts[`$basketindex`][am]"}]
                            [{assign var="getStock" value=$basketitem->getArticle()}]
                            [{include file="widget/product/tobasket.tpl" blCanBuy=true name=$tobasket_name value=$basketitem->getAmount() stockflag=$getStock->oxarticles__oxstockflag->value stock=$getStock->oxarticles__oxstock->value}]
                            [{if $basketitem->oxarticles__oxunitname->value}]
                                [{$basketitem->oxarticles__oxunitname->value}]
                            [{/if}]

                        [{/if}]

                    [{else}]

                        [{include file="widget/product/tobasket.tpl" blCanBuy=true name=$tobasket_name value=$basketitem->getAmount() disabled=true}]

                    [{/if}]

                    [{if $basketitem->getdBundledAmount() > 0 && ($basketitem->isBundle() || $basketitem->isDiscountArticle())}]
                        +[{$basketitem->getdBundledAmount()}]
                    [{/if}]

                [{/block}]

                [{block name="checkout_basketcontents_basketitem_totalprice"}]
                    [{* product quantity * price *}]
                    <div class="component__basketarticle-price">
                        [{oxprice price=$basketitem->getPrice() currency=$currency}]
                    </div>
                [{/block}]

            </div>
            [{block name="checkout_basketcontents_basketitem_end"}][{/block}]
        </div>
    [{/block}]

    [{* packing unit *}]

    [{block name="checkout_basketcontents_itemerror"}]
        [{foreach from=$Errors.basket item=oEr key=key}]
            [{if $oEr->getErrorClassType() == 'oxOutOfStockException'}]
                [{* display only the exceptions for the current article *}]
                [{if $basketindex == $oEr->getValue('basketIndex')}]
                    <tr class="basketError">
                        [{if $editable}]<td></td>[{/if}]
                            <td colspan="5">
                                <span class="inlineError">[{$oEr->getOxMessage()}] <strong>[{$oEr->getValue('remainingAmount')}]</strong></span>
                            </td>
                        [{if $oView->isWrapping()}]<td></td>[{/if}]
                        <td></td>
                    </tr>
                [{/if}]
            [{/if}]
            [{if $oEr->getErrorClassType() == 'oxArticleInputException'}]
                [{if $basketitem->getProductId() == $oEr->getValue('productId')}]
                    <tr class="basketError">
                        [{if $editable}]<td></td>[{/if}]
                        <td colspan="5">
                            <span class="inlineError">[{$oEr->getOxMessage()}]</span>
                        </td>
                        [{if $oView->isWrapping()}]<td></td>[{/if}]
                        <td></td>
                    </tr>
                [{/if}]
            [{/if}]
        [{/foreach}]
    [{/block}]
    [{*  basket items end  *}]
[{/foreach}]

[{block name="checkout_basketcontents_giftwrapping"}]
    [{if $oViewConf->getShowGiftWrapping()}]
        [{assign var="oCard" value=$oxcmp_basket->getCard()}]
        [{if $oCard}]
            <tr>
                [{if $editable}]<td></td>[{/if}]
                <td id="orderCardTitle" colspan="3">[{oxmultilang ident="GREETING_CARD"}] "[{$oCard->oxwrapping__oxname->value}]"
                    <br>
                    <b>[{oxmultilang ident="YOUR_MESSAGE"}]</b>
                    <br>
                    <div id="orderCardText">[{$oxcmp_basket->getCardMessage()|nl2br}]</div>
                </td>
                <td id="orderCardPrice">[{$oCard->getFPrice()}]&nbsp;[{$currency->sign}]</td>
                <td>
                    [{if $oxcmp_basket->isProportionalCalculationOn()}]
                        [{oxmultilang ident="PROPORTIONALLY_CALCULATED"}]
                    [{else}]
                        [{if $oxcmp_basket->getGiftCardCostVat()}][{$oxcmp_basket->getGiftCardCostVatPercent()}]%[{/if}]
                    [{/if}]
                </td>
                <td id="orderCardTotalPrice" align="right">[{$oCard->getFPrice()}]&nbsp;[{$currency->sign}]</td>
            </tr>
        [{/if}]
    [{/if}]
[{/block}]

[{block name="checkout_basketcontents_basketfunctions"}][{/block}]
