[{if $oViewConf->getTopActionClassName() != 'clearcookies' && $oViewConf->getTopActionClassName() != 'mallstart'}]
    [{oxid_include_widget cl="oxwCookieNote" _parent=$oView->getClassName() nocookie=1}]
[{/if}]

[{block name="header_main"}]
    <header[{if !$oView->showSearch() && $oView->getClassName() != "basket"}] class="is-minimal"[{/if}]>
        <div class="container-xxl">

            [{if $oView->showSearch() || $oView->getClassName() == "basket"}]
            [{block name="layout_header_topinfo"}]
                <div class="header__topinfo d-none d-lg-flex">

                    [{block name="layout_header_topinfo_phone"}]
                        <div class="d-none d-lg-flex align-items-center gap-2">
                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M18.264 13.559L16.686 11.982c-.418-.418-.985-.653-1.576-.653s-1.158.235-1.576.653l-.789.788c-.207.207-.453.372-.723.484-.27.111-.56.169-.852.169s-.582-.058-.852-.169c-.27-.112-.516-.277-.723-.484l-2.364-2.366c-.418-.418-.653-.985-.653-1.576s.235-1.158.653-1.577l.788-.788c.418-.417.653-.984.653-1.576s-.235-1.158-.653-1.576L6.448 1.734c-.194-.23-.435-.414-.707-.541A2.003 2.003 0 0 0 4.872 1c-.3 0-.597.065-.87.192-.272.127-.513.311-.707.541C-0.847 5.849 1.109 10.601 5.25 14.743c4.14 4.141 8.89 6.1 13.012 1.972.23-.193.414-.435.541-.707.127-.272.192-.569.192-.869 0-.3-.065-.597-.192-.87-.127-.272-.311-.513-.541-.707z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <a href="tel:[{$oxcmp_shop->oxshops__oxtelefon->value}]">
                                [{$oxcmp_shop->oxshops__oxtelefon->value}]
                            </a>
                        </div>
                    [{/block}]

                    [{block name="layout_header_topinfo_cms"}]
                        [{oxifcontent ident="o3headerTopInfo" object="oCont"}]
                            <div class="flex-grow-1 d-flex justify-content-center align-items-center gap-2 text-truncate">
                                [{$oCont->oxcontents__oxcontent->value}]
                            </div>
                        [{/oxifcontent}]
                    [{/block}]

                    [{block name="layout_header_topinfo_lang_curr"}]
                        <div class="d-none d-lg-flex">
                            [{block name="dd_layout_page_header_icon_menu_languages"}]
                                [{oxid_include_widget cl="oxwLanguageList" lang=$oViewConf->getActLanguageId() _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]
                            [{/block}]
                            [{block name="dd_layout_page_header_icon_menu_currencies"}]
                                [{oxid_include_widget cl="oxwCurrencyList" cur=$oViewConf->getActCurrency() _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]
                            [{/block}]
                        </div>
                    [{/block}]

                </div>
            [{/block}]
            [{/if}]

            [{block name="layout_header_logo"}]
                [{assign var="slogoImg" value=$oViewConf->getViewThemeParam('sLogoFile')}]
                <a class="header__logo" href="[{$oViewConf->getHomeLink()}]" title="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]">
                    <img class="img-fluid" src="[{$oViewConf->getImageUrl($slogoImg)}]" alt="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]">
                </a>
            [{/block}]

            <div class="header__actions">
                [{block name="layout_header_top"}]

                    [{block name="dd_layout_page_header_icon_menu_account"}]
                        [{if $oxcmp_user || $oView->getCompareItemCount() || $Errors.loginBoxErrors}]
                            [{assign var="blAnon" value=0}]
                            [{assign var="force_sid" value=$oViewConf->getSessionId()}]
                        [{else}]
                            [{assign var="blAnon" value=1}]
                        [{/if}]
                        [{oxid_include_widget cl="oxwServiceMenu" _parent=$oView->getClassName() force_sid=$force_sid nocookie=$blAnon _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]
                    [{/block}]

                    <a class="header__actions-noticelist btn position-relative" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_noticelist"}]">
                        <svg width="22" height="19" viewBox="0 0 22 19" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M6.5 1C3.4625 1 1 3.4625 1 6.5C1 12 7.5 17 11 18.163C14.5 17 21 12 21 6.5C21 3.4625 18.5375 1 15.5 1C13.64 1 11.995 1.9235 11 3.337C10.4928 2.6146 9.81908 2.02505 9.03577 1.61824C8.25245 1.21144 7.38265 0.999377 6.5 1Z" stroke="#112211" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span class="badge-counter">
                            [{if $oxcmp_user && $oxcmp_user->getNoticeListArtCnt()}]
                                [{$oxcmp_user->getNoticeListArtCnt()}]
                            [{else}]
                                0
                            [{/if}]
                        </span>
                    </a>

                    [{block name="dd_layout_page_header_icon_menu_minibasket"}]
                        [{if $oxcmp_basket->getProductsCount()}]
                            [{assign var="blAnon" value=0}]
                            [{assign var="force_sid" value=$oViewConf->getSessionId()}]
                        [{else}]
                            [{assign var="blAnon" value=1}]
                        [{/if}]

                        [{oxid_include_widget cl="oxwMiniBasket" nocookie=$blAnon force_sid=$force_sid pimmel="basket"}]

                    [{/block}]

                [{/block}]
            </div>

            [{if $oView->showSearch() || $oView->getClassName() == "basket"}]
                <div class="header__search">
                    [{include file="widget/header/search.tpl"}]
                </div>
            [{/if}]

            [{block name="layout_header_bottom"}]
                [{oxid_include_widget cl="oxwCategoryTree" cnid=$oView->getCategoryId() sWidgetType="header" _parent=$oView->getClassName() nocookie=1}]
            [{/block}]

            [{if $oView->showSearch() || $oView->getClassName() == "basket"}]
                <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvas__mainnav">
                    <div class="offcanvas-header">
                        [{assign var="slogoImg" value=$oViewConf->getViewThemeParam('sLogoFile')}]
                        <img class="offcanvas__mainnav-logo" src="[{$oViewConf->getImageUrl($slogoImg)}]" alt="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]">
                        [{block name="dd_layout_page_header_icon_menu_languages"}]
                            [{oxid_include_widget cl="oxwLanguageList" lang=$oViewConf->getActLanguageId() _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]
                        [{/block}]
                        [{block name="dd_layout_page_header_icon_menu_currencies"}]
                            [{oxid_include_widget cl="oxwCurrencyList" cur=$oViewConf->getActCurrency() _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]
                        [{/block}]
                        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                    </div>
                    <div class="offcanvas-body">
                        [{include file="widget/header/categorylist_offcanvas.tpl"}]
                    </div>
                </div>
            [{/if}]

        </div>
    </header>
[{/block}]

[{oxid_include_dynamic file="widget/minibasket/minibasketmodal.tpl"}]
