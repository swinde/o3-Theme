[{assign var="oConfig" value=$oViewConf->getConfig()}]
[{assign var="oManufacturer" value=$oView->getManufacturer()}]
[{assign var="aVariantSelections" value=$oView->getVariantSelections()}]

[{if $aVariantSelections && $aVariantSelections.rawselections}]
    [{assign var="_sSelectionHashCollection" value=""}]
    [{foreach from=$aVariantSelections.rawselections item=oSelectionList key=iKey}]
        [{assign var="_sSelectionHash" value=""}]
        [{foreach from=$oSelectionList item=oListItem key=iPos}]
            [{assign var="_sSelectionHash" value=$_sSelectionHash|cat:$iPos|cat:":"|cat:$oListItem.hash|cat:"|"}]
        [{/foreach}]
        [{if $_sSelectionHash}]
            [{if $_sSelectionHashCollection}][{assign var="_sSelectionHashCollection" value=$_sSelectionHashCollection|cat:","}][{/if}]
            [{assign var="_sSelectionHashCollection" value=$_sSelectionHashCollection|cat:"'`$_sSelectionHash`'"}]
        [{/if}]
    [{/foreach}]

    <form class="js-oxWidgetReload" action="[{$oView->getWidgetLink()}]" method="get">
        [{$oViewConf->getHiddenSid()}]
        [{$oViewConf->getNavFormParams()}]
        <input type="hidden" name="cl" value="[{$oView->getClassName()}]">
        <input type="hidden" name="oxwparent" value="[{$oViewConf->getTopActiveClassName()}]">
        <input type="hidden" name="listtype" value="[{$oView->getListType()}]">
        <input type="hidden" name="nocookie" value="1">
        <input type="hidden" name="cnid" value="[{$oView->getCategoryId()}]">
        <input type="hidden" name="anid" value="[{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}]">
        <input type="hidden" name="actcontrol" value="[{$oViewConf->getTopActiveClassName()}]">
        [{if $oConfig->getRequestParameter('preview')}]
            <input type="hidden" name="preview" value="[{$oConfig->getRequestParameter('preview')}]">
        [{/if}]
    </form>
[{/if}]

[{oxhasrights ident="TOBASKET"}]
    <form class="js-oxProductForm details" action="[{$oViewConf->getSelfActionLink()}]" method="post">
        <div class="d-none">
            [{$oViewConf->getHiddenSid()}]
            [{$oViewConf->getNavFormParams()}]
            <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]">
            <input type="hidden" name="aid" value="[{$oDetailsProduct->oxarticles__oxid->value}]">
            <input type="hidden" name="anid" value="[{$oDetailsProduct->oxarticles__oxnid->value}]">
            <input type="hidden" name="parentid" value="[{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}]">
            <input type="hidden" name="panid" value="">
            [{if !$oDetailsProduct->isNotBuyable()}]
                <input type="hidden" name="fnc" value="tobasket">
            [{/if}]
        </div>
[{/oxhasrights}]

[{block name="details_productmain_title"}]
    <h1 class="details__title" itemprop="name">
        [{$oDetailsProduct->oxarticles__oxtitle->value}] [{$oDetailsProduct->oxarticles__oxvarselect->value}]
    </h1>
[{/block}]

<div class="details__info">

    [{if $oManufacturer}]
        <meta itemprop="brand" content="[{$oManufacturer->oxmanufacturers__oxtitle->value}]">
    [{/if}]

    [{if $oView->ratingIsActive()}]
        [{block name="details_productmain_ratings"}]
            [{include file="widget/reviews/rating.tpl" iRatingValue=$oView->getRatingValue() iRatingCount=$oView->getRatingCount() id=$oDetailsProduct->oxarticles__oxid->value}]
        [{/block}]
    [{/if}]

    [{block name="details_productmain_stockstatus"}]
        [{if $oDetailsProduct->getStockStatus() == -1}]
            <div class="details__info-stock notOnStock">
                [{if $oDetailsProduct->oxarticles__oxnostocktext->value}]
                    [{$oDetailsProduct->oxarticles__oxnostocktext->value}]
                [{elseif $oViewConf->getStockOffDefaultMessage()}]
                    [{oxmultilang ident="MESSAGE_NOT_ON_STOCK"}]
                [{/if}]
                [{if $oDetailsProduct->getDeliveryDate()}]
                    [{oxmultilang ident="AVAILABLE_ON"}] [{$oDetailsProduct->getDeliveryDate()}]
                [{/if}]
            </div>
        [{elseif $oDetailsProduct->getStockStatus() == 1}]
            <div class="details__info-stock lowStock">
                [{oxmultilang ident="LOW_STOCK"}]
            </div>
        [{elseif $oDetailsProduct->getStockStatus() == 0}]
            <div class="details__info-stock">
                [{if $oDetailsProduct->oxarticles__oxstocktext->value}]
                    [{$oDetailsProduct->oxarticles__oxstocktext->value}]
                [{elseif $oViewConf->getStockOnDefaultMessage()}]
                    [{oxmultilang ident="READY_FOR_SHIPPING"}]
                [{/if}]
            </div>
        [{/if}]
    [{/block}]

    [{oxhasrights ident="TOBASKET"}]
        [{if $oDetailsProduct->isBuyable()}]
            [{block name="details_productmain_deliverytime"}]
                [{include file="page/details/inc/deliverytime.tpl"}]
            [{/block}]
        [{/if}]
    [{/oxhasrights}]

    [{* article number *}]
    [{block name="details_productmain_artnumber"}]
        <div class="details__info-artnum" itemprop="sku" content="[{$oDetailsProduct->oxarticles__oxartnum->value}]">[{oxmultilang ident="O3_ARTNUM" suffix="COLON"}] [{$oDetailsProduct->oxarticles__oxartnum->value}]</div>
    [{/block}]

    [{block name="details_productmain_shortdesc"}]
    [{/block}]
</div>

[{block name="details_productmain_morepics"}]
    [{include file="page/details/inc/pictures.tpl"}]
[{/block}]

<div itemprop="offers" itemscope itemtype="https://schema.org/Offer" class="details__wrapper">
    <meta itemprop="url" content="[{$oDetailsProduct->getMainLink()}]">

    [{* additional info *}]
    [{oxhasrights ident="SHOWARTICLEPRICE"}]
        [{assign var="oUnitPrice" value=$oDetailsProduct->getUnitPrice()}]
        [{block name="details_productmain_priceperunit"}]
            [{if $oUnitPrice}]
                <div class="details-additional-information">
                    [{oxprice price=$oUnitPrice currency=$currency}]/[{$oDetailsProduct->getUnitName()}]
                </div>
            [{/if}]
        [{/block}]
    [{/oxhasrights}]

    [{if $oDetailsProduct->oxarticles__oxweight->value}]
        [{block name="details_productmain_weight"}]
            <meta itemprop="weight" content="[{$oDetailsProduct->oxarticles__oxweight->value}] kg">
        [{/block}]
    [{/if}]

    [{block name="details_productmain_vpe"}]
        [{if $oDetailsProduct->oxarticles__oxvpe->value > 1}]
            <span class="vpe small">[{oxmultilang ident="DETAILS_VPE_MESSAGE_1"}] [{$oDetailsProduct->oxarticles__oxvpe->value}] [{oxmultilang ident="DETAILS_VPE_MESSAGE_2"}]</span>
        [{/if}]
    [{/block}]

    [{assign var="blCanBuy" value=true}]
    [{* variants | md variants *}]
    [{block name="details_productmain_variantselections"}]
        [{if $aVariantSelections && $aVariantSelections.selections}]

            [{if $oxcmp_shop->oxshops__oxproductive->value}]
                [{oxscript include="js/widget/variants.min.js" priority=10}]
            [{else}]
                [{oxscript include="js/widget/variants.js" priority=10}]
            [{/if}]

            [{assign var="blCanBuy" value=$aVariantSelections.blPerfectFit}]
            [{if !$blHasActiveSelections}]
                [{if !$blCanBuy && !$oDetailsProduct->isParentNotBuyable()}]
                    [{assign var="blCanBuy" value=true}]
                [{/if}]
            [{/if}]
            <div id="variants" class="details__variants">
                [{assign var="blHasActiveSelections" value=false}]
                [{assign var="iActiveSelections" value=0}]
                [{assign var="iTotalSelections" value=$aVariantSelections.selections|@count}]
                [{foreach from=$aVariantSelections.selections item=oList key=iKey}]
                    [{if $oList->getActiveSelection()}]
                        [{assign var="blHasActiveSelections" value=true}]
                        [{assign var="iActiveSelections" value=$iActiveSelections+1}]
                    [{/if}]
                    [{include file="widget/product/selectbox.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                [{/foreach}]
            </div>

            [{if $iActiveSelections == $iTotalSelections && !$blCanBuy}]
                <div class="alert alert-warning mt-0">
                    [{oxmultilang ident="DETAILS_VARIANT_NOT_AVAILABLE"}]
                </div>
            [{/if}]
        [{/if}]
    [{/block}]

    [{* selection lists *}]
    [{block name="details_productmain_selectlists"}]
        [{if $oViewConf->showSelectLists()}]
            [{assign var="oSelections" value=$oDetailsProduct->getSelections()}]
            [{if $oSelections}]
                <div id="variants" class="details__variants">
                    [{foreach from=$oSelections item=oList name=selections}]
                        [{include file="widget/product/selectbox.tpl" oSelectionList=$oList sFieldName="sel" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop"}]
                    [{/foreach}]
                </div>
            [{/if}]
        [{/if}]
    [{/block}]

    <div class="details__price">

        [{block name="details_productmain_watchlist"}][{/block}]

        [{block name="details_productmain_price"}]
            [{oxhasrights ident="SHOWARTICLEPRICE"}]
                [{block name="details_productmain_price_value"}]

                    [{if $oDetailsProduct->loadAmountPriceInfo()}]
                        [{include file="page/details/inc/priceinfo.tpl"}]
                    [{/if}]

                    [{block name="details_productmain_tprice"}]
                        [{strip}]
                            <del class="details__price-old">
                                [{if $oDetailsProduct->getTPrice()}]
                                    [{oxprice price=$oDetailsProduct->getTPrice() currency=$currency}]
                                [{/if}]
                            </del>
                        [{/strip}]
                    [{/block}]

                    [{if $oDetailsProduct->getFPrice()}]
                        [{assign var="sFrom" value=""}]
                        [{assign var="oPrice" value=$oDetailsProduct->getPrice()}]
                        [{if $oDetailsProduct->isParentNotBuyable()}]
                            [{assign var="oPrice" value=$oDetailsProduct->getVarMinPrice()}]
                            [{if $oDetailsProduct->isRangePrice()}]
                                [{assign var="sFrom" value="PRICE_FROM"|oxmultilangassign}]
                            [{/if}]
                        [{/if}]
                        [{*<span[{if $oDetailsProduct->getTPrice()}] class="text-danger"[{/if}]>*}]

                        <div class="details__price-main">
                            [{if $sFrom}]<span>[{$sFrom}]</span>[{/if}] [{oxprice price=$oPrice currency=$currency}]
                        </div>

                        [{if $oView->isVatIncluded()}]
                            <div class="details__price-vat">
                                [{oxifcontent ident="oxdeliveryinfo" object="oCont"}]
                                    [{oxmultilang ident="PLUS_SHIPPING"}]<a href="#modal__deliverycost" data-bs-toggle="modal" role="button" aria-controls="modal__deliverycost">[{oxmultilang ident="PLUS_SHIPPING2"}]</a>

                                    <div class="modal fade" id="modal__deliverycost" tabindex="-1" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    [{$oCont->oxcontents__oxcontent->value}]
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                [{/oxifcontent}]
                            </div>
                        [{/if}]

                        <meta itemprop="price" content="[{$oPrice->getPrice()}]">
                        <meta itemprop="priceCurrency" content="[{$currency->name}]">

                        [{if $oDetailsProduct->getStockStatus() == -1}]
                            [{if $oDetailsProduct->oxarticles__oxnostocktext->value || $oViewConf->getStockOffDefaultMessage()}]
                                <link itemprop="availability" href="https://schema.org/OutOfStock"/>
                            [{/if}]
                            [{if $oDetailsProduct->getDeliveryDate()}]
                                <link itemprop="availability" href="https://schema.org/PreOrder"/>
                            [{/if}]
                        [{elseif $oDetailsProduct->getStockStatus() == 1 || $oDetailsProduct->getStockStatus() == 0}]
                            <link itemprop="availability" href="https://schema.org/InStock"/>
                        [{/if}]

                        [{*</span>*}]
                    [{/if}]
                [{/block}]
            [{/oxhasrights}]
        [{/block}]
    </div>

    [{block name="o3_details_guarantee_label"}]
        [{assign var="oGuaranteeArticle" value=$oDetailsProduct}]
        [{assign var="sGuaranteeContext" value="o3-guarantee--detail"}]
        [{include file="page/details/inc/guaranteelabel.tpl"}]
    [{/block}]

    [{block name="details_productmain_productlinksselector"}]
        [{block name="details_productmain_productlinks"}]
            <div class="details__share">
                [{if $oxcmp_user}]
                    <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl="|cat:$oViewConf->getTopActiveClassName() params="aid=`$oDetailsProduct->oxarticles__oxnid->value`&amp;anid=`$oDetailsProduct->oxarticles__oxnid->value`&amp;fnc=tonoticelist&amp;am=1"|cat:$oViewConf->getNavUrlParams()|cat:"&amp;stoken="|cat:$oViewConf->getSessionChallengeToken()}]">
                        [{if $oDetailsProduct->isInList()}]
                            <svg width="20" height="17" viewBox="0 0 20 17" xmlns="http://www.w3.org/2000/svg">
                                <path d="M5.95 1.06397C3.21625 1.06397 1 3.21612 1 5.87082C1 10.6777 6.85 15.0475 10 16.064C13.15 15.0475 19 10.6777 19 5.87082C19 3.21612 16.7837 1.06397 14.05 1.06397C12.376 1.06397 10.8955 1.87108 10 3.10644C9.54356 2.47508 8.93717 1.95983 8.23219 1.60429C7.52721 1.24876 6.74438 1.06342 5.95 1.06397Z" fill="#929292" stroke="#929292" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        [{else}]
                            <svg width="20" height="17" viewBox="0 0 20 17" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M5.95 1.06397C3.21625 1.06397 1 3.21612 1 5.87082C1 10.6777 6.85 15.0475 10 16.064C13.15 15.0475 19 10.6777 19 5.87082C19 3.21612 16.7837 1.06397 14.05 1.06397C12.376 1.06397 10.8955 1.87108 10 3.10644C9.54356 2.47508 8.93717 1.95983 8.23219 1.60429C7.52721 1.24876 6.74438 1.06342 5.95 1.06397Z" stroke="#929292" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        [{/if}]
                    </a>
                [{else}]
                    <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account" params="anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:"&amp;sourcecl="|cat:$oViewConf->getTopActiveClassName()|cat:$oViewConf->getNavUrlParams()}]">
                        <svg width="20" height="17" viewBox="0 0 20 17" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M5.95 1.06397C3.21625 1.06397 1 3.21612 1 5.87082C1 10.6777 6.85 15.0475 10 16.064C13.15 15.0475 19 10.6777 19 5.87082C19 3.21612 16.7837 1.06397 14.05 1.06397C12.376 1.06397 10.8955 1.87108 10 3.10644C9.54356 2.47508 8.93717 1.95983 8.23219 1.60429C7.52721 1.24876 6.74438 1.06342 5.95 1.06397Z" stroke="#929292" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </a>
                [{/if}]
                [{*
                <a tabindex="0" data-bs-toggle="popover" data-bs-trigger="focus" data-bs-placement="left" data-bs-content="">
                    <svg width="20" height="21" viewBox="0 0 20 21" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M13.014 15.2L6.986 12.458M13.112 6.14596L6.888 9.54097M4.015 14.373C4.44377 14.373 4.86833 14.2885 5.26446 14.1244C5.66059 13.9604 6.02052 13.7199 6.3237 13.4167C6.62689 13.1135 6.86738 12.7536 7.03147 12.3574C7.19555 11.9613 7.28 11.5367 7.28 11.108C7.28 10.6792 7.19555 10.2546 7.03147 9.8585C6.86738 9.46238 6.62689 9.10244 6.3237 8.79926C6.02052 8.49608 5.66059 8.25558 5.26446 8.0915C4.86833 7.92742 4.44377 7.84297 4.015 7.84297C3.14907 7.84297 2.3186 8.18695 1.7063 8.79926C1.09399 9.41157 0.75 10.242 0.75 11.108C0.75 11.9739 1.09399 12.8044 1.7063 13.4167C2.3186 14.029 3.14907 14.373 4.015 14.373ZM15.985 7.84396C16.4138 7.84396 16.8383 7.75951 17.2345 7.59543C17.6306 7.43135 17.9905 7.19085 18.2937 6.88767C18.5969 6.58449 18.8374 6.22455 19.0015 5.82843C19.1655 5.4323 19.25 5.00773 19.25 4.57896C19.25 4.1502 19.1655 3.72563 19.0015 3.3295C18.8374 2.93338 18.5969 2.57344 18.2937 2.27026C17.9905 1.96708 17.6306 1.72658 17.2345 1.5625C16.8383 1.39842 16.4138 1.31396 15.985 1.31396C15.1191 1.31396 14.2886 1.65795 13.6763 2.27026C13.064 2.88257 12.72 3.71303 12.72 4.57896C12.72 5.4449 13.064 6.27536 13.6763 6.88767C14.2886 7.49997 15.1191 7.84396 15.985 7.84396ZM15.985 19.814C16.8509 19.814 17.6814 19.47 18.2937 18.8577C18.906 18.2454 19.25 17.4149 19.25 16.549C19.25 15.683 18.906 14.8526 18.2937 14.2403C17.6814 13.628 16.8509 13.284 15.985 13.284C15.1191 13.284 14.2886 13.628 13.6763 14.2403C13.064 14.8526 12.72 15.683 12.72 16.549C12.72 17.4149 13.064 18.2454 13.6763 18.8577C14.2886 19.47 15.1191 19.814 15.985 19.814Z" stroke="#929292" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </a>
                *}]
            </div>
        [{/block}]
    [{/block}]

    [{* pers params *}]
    [{block name="details_productmain_persparams"}]
        [{if $oView->isPersParam()}]
            <div class="persparamBox clear form-group">
                <label for="persistentParam" class="control-label">[{oxmultilang ident="LABEL"}]</label>
                <input type="text" id="persistentParam" name="persparam[details]" value="[{$oDetailsProduct->aPersistParam.text}]" size="35" class="form-control">
            </div>
        [{/if}]
    [{/block}]

    [{block name="details_productmain_tobasket"}]
        [{oxhasrights ident="TOBASKET"}]
            [{if !$oDetailsProduct->isNotBuyable()}]
                [{include file="widget/product/tobasket.tpl" blCanBuy=$blCanBuy name="am" value=1 stockflag=$oDetailsProduct->oxarticles__oxstockflag->value stock=$oDetailsProduct->oxarticles__oxstock->value submit=true}]
            [{/if}]
        [{/oxhasrights}]
    [{/block}]

    [{block name="details_productmain_social"}]
    [{/block}]
</div>

[{oxhasrights ident="TOBASKET"}]
    </form>
[{/oxhasrights}]
