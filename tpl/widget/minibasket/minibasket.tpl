[{capture name="cartTable"}]
    [{assign var="oConfig" value=$oViewConf->getConfig()}]

    <form name="basket[{$basketindex}]" action="[{$oViewConf->getSelfActionLink()}]" method="post" class="offcanvas__basket-articles">
        [{$oViewConf->getHiddenSid()}]
        <input type="hidden" name="cl" value="basket">
        <input type="hidden" name="fnc" value="changebasket">
        <input type="hidden" name="CustomError" value="basket">

        [{foreach key=basketindex from=$oxcmp_basket->getContents() name=miniBasketList item=_product}]
            [{block name="widget_minibasket_product"}]
                [{assign var="minibasketItemTitle" value=$_product->getTitle()}]
                <div class="component__basketarticle">

                    <a href="[{$_product->getLink()}]" title="[{$minibasketItemTitle|strip_tags}]">
                        <img src="[{$_product->getIconUrl()}]" alt="[{$minibasketItemTitle|strip_tags}]"/>
                    </a>

                    <div class="component__basketarticle-info">
                        <a class="component__basketarticle-title" href="[{$_product->getLink()}]" title="[{$minibasketItemTitle|strip_tags}]">[{$_product->getAmount()}] x [{$minibasketItemTitle|strip_tags}]</a>

                        <input type="hidden" name="aproducts[[{$basketindex}]][remove]" value="0">
                        <button type="submit" name="removeBtn" class="component__basketarticle-remove btn" data-remove-id="aproducts[[{$basketindex}]][remove]" data-js="remove-from-basket">
                            <svg width="18" height="20" viewBox="0 0 18 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M5.4375 2.3125H5.25C5.35313 2.3125 5.4375 2.22812 5.4375 2.125V2.3125ZM5.4375 2.3125H12.5625V2.125C12.5625 2.22812 12.6469 2.3125 12.75 2.3125H12.5625V4H14.25V2.125C14.25 1.29766 13.5773 0.625 12.75 0.625H5.25C4.42266 0.625 3.75 1.29766 3.75 2.125V4H5.4375V2.3125ZM17.25 4H0.75C0.335156 4 0 4.33516 0 4.75V5.5C0 5.60313 0.084375 5.6875 0.1875 5.6875H1.60312L2.18203 17.9453C2.21953 18.7445 2.88047 19.375 3.67969 19.375H14.3203C15.1219 19.375 15.7805 18.7469 15.818 17.9453L16.3969 5.6875H17.8125C17.9156 5.6875 18 5.60313 18 5.5V4.75C18 4.33516 17.6648 4 17.25 4ZM14.1398 17.6875H3.86016L3.29297 5.6875H14.707L14.1398 17.6875Z" fill="#D4D4D4"/>
                            </svg>
                        </button>

                        <input type="hidden" name="aproducts[[{$basketindex}]][aid]" value="[{$_product->getProductId()}]">
                        <input type="hidden" name="aproducts[[{$basketindex}]][basketitemid]" value="[{$basketindex}]">
                        <input type="hidden" name="aproducts[[{$basketindex}]][override]" value="1">
                        [{if $_product->isBundle()}]
                            <input type="hidden" name="aproducts[[{$basketindex}]][bundle]" value="1">
                        [{/if}]

                        [{assign var="tobasket_name" value="aproducts[`$basketindex`][am]"}]
                        [{assign var="getStock" value=$_product->getArticle()}]
                        [{*include file="widget/product/tobasket.tpl" blCanBuy=true name=$tobasket_name value=$_product->getAmount() stockflag=$getStock->oxarticles__oxstockflag->value stock=$getStock->oxarticles__oxstock->value*}]

                        <div class="component__basketarticle-price">[{oxprice price=$_product->getPrice() currency=$currency}]</div>
                    </div>

                </div>
            [{/block}]
        [{/foreach}]
    </form>

    <div class="offcanvas__basket-costs">
        <div>
            [{oxmultilang ident="TOTAL_GROSS"}]
        </div>
        <div>
            [{if $oxcmp_basket->isPriceViewModeNetto()}]
                [{oxprice price=$oxcmp_basket->getNettoSum() currency=$currency}]
            [{else}]
                [{oxprice price=$oxcmp_basket->getBruttoSum() currency=$currency}]
            [{/if}]
        </div>
    </div>
[{/capture}]

[{block name="widget_minibasket"}]
    [{if $oxcmp_basket->getProductsCount()}]
        [{oxhasrights ident="TOBASKET"}]
            [{assign var="currency" value=$oView->getActCurrency()}]

            [{block name="widget_minibasket_modal_header"}]
            [{/block}]
            [{block name="widget_minibasket_modal_content"}]
            [{/block}]
            [{block name="widget_minibasket_modal_footer"}]
            [{/block}]

            [{block name="dd_layout_page_header_icon_menu_minibasket_title"}]
                <div class="offcanvas-header">
                    <h5 class="offcanvas-title title-big">[{oxmultilang ident="CART"}]<span>[{$oxcmp_basket->getItemsCount()}] [{oxmultilang ident="O3_ARTICLE"}]</span></h5>
                    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
            [{/block}]

            <div class="offcanvas-body d-flex flex-column">

                [{if $oxcmp_basket->isNewItemAdded()}]
                    <div class="alert alert-success mb-5">
                        [{oxmultilang ident="NEW_BASKET_ITEM_MSG"}]
                    </div>
                [{/if}]

                [{block name="dd_layout_page_header_icon_menu_minibasket_table"}]
                    [{$smarty.capture.cartTable}]
                    [{block name="widget_minibasket_total"}][{/block}]
                [{/block}]

                [{include file="widget/minibasket/countdown.tpl"}]

                [{block name="dd_layout_page_header_icon_menu_minibasket_functions"}]
                    <div class="offcanvas__basket-navigation">
                        <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=basket"}]" class="btn btn-outline-primary btn-lg">[{oxmultilang ident="DISPLAY_BASKET"}]</a>
                        [{if $oxcmp_user}]
                            <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=payment"}]" class="btn btn-primary btn-lg">[{oxmultilang ident="CHECKOUT"}]</a>
                        [{else}]
                            <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=user"}]" class="btn btn-primary btn-lg">[{oxmultilang ident="CHECKOUT"}]</a>
                        [{/if}]
                    </div>
                [{/block}]
            </div>

        [{/oxhasrights}]
    [{else}]
        [{block name="dd_layout_page_header_icon_menu_minibasket_alert_empty"}]
            <div class="offcanvas-header">
                <h5 class="offcanvas-title title-big">[{oxmultilang ident="CART"}]</h5>
                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body offcanvas__basket-empty">
                <svg width="167" height="143" viewBox="0 0 167 143" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M10.1715 102.686C25.6674 146.366 102.293 156.418 138.01 123.171C173.726 89.9246 162.585 33.0874 139.422 15.0394C106.201 -10.824 75.7251 25.9843 50.2535 30.4102C24.782 34.8362 -5.29566 59.087 10.1715 102.686Z" fill="#F3F6FF"/>
                    <path d="M102.996 49.7906C116.826 58.9987 121.187 79.827 112.216 93.8115C103.246 107.796 82.5126 112.513 68.3618 103.792C54.2109 95.0709 49.1494 74.3971 57.6684 60.1156C66.1874 45.8341 87.3365 39.3587 102.996 49.7906Z" fill="#011635"/>
                    <g style="mix-blend-mode:multiply" opacity="0.18">
                        <path d="M112.226 93.8113C115.397 88.7331 117.019 82.8416 116.896 76.8564C96.6261 95.6054 70.1185 94.6074 58.0469 92.9083C60.526 97.3413 64.0756 101.083 68.3719 103.792C82.5109 112.513 103.256 107.796 112.226 93.8113Z" fill="#011635"/>
                    </g>
                    <path d="M76.9297 69.3355C76.6578 68.672 76.2181 68.0906 75.6538 67.6484C75.0894 67.2062 74.4196 66.9183 73.7104 66.8131C73.0011 66.7079 72.2767 66.7889 71.6082 67.0482C70.9398 67.3075 70.3502 67.7362 69.8974 68.2922C69.4447 68.8481 69.1443 69.5123 69.0257 70.2195C68.9072 70.9266 68.9745 71.6524 69.2212 72.3257C69.4679 72.9989 69.8855 73.5964 70.4329 74.0596C70.9802 74.5227 71.6386 74.8355 72.3434 74.9673C73.0589 75.0368 73.7805 74.9283 74.444 74.6515C75.1074 74.3747 75.6921 73.9381 76.1461 73.3807C76.6 72.8233 76.9091 72.1623 77.0458 71.4565C77.1825 70.7508 77.1426 70.0222 76.9297 69.3355Z" fill="#011635" stroke="#011635" stroke-width="2.94582" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M102.106 69.3357C101.835 68.6714 101.395 68.0893 100.83 67.6466C100.265 67.2039 99.5948 66.9158 98.8848 66.8107C98.1749 66.7056 97.4498 66.7871 96.7809 67.0472C96.1121 67.3073 95.5224 67.737 95.0699 68.294C94.6174 68.8511 94.3177 69.5164 94.2003 70.2244C94.0829 70.9324 94.1518 71.6587 94.4002 72.3321C94.6486 73.0054 95.068 73.6024 95.6171 74.0645C96.1663 74.5266 96.8262 74.8378 97.532 74.9675C98.2474 75.0379 98.969 74.9299 99.6324 74.6531C100.296 74.3763 100.88 73.9394 101.333 73.3815C101.787 72.8235 102.094 72.162 102.229 71.4559C102.364 70.7499 102.322 70.0214 102.106 69.3357Z" fill="#011635" stroke="#011635" stroke-width="2.94582" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M3.44309 15.1531C4.01245 15.1531 4.47402 14.6916 4.47402 14.1222C4.47402 13.5529 4.01245 13.0913 3.44309 13.0913C2.87373 13.0913 2.41217 13.5529 2.41217 14.1222C2.41217 14.6916 2.87373 15.1531 3.44309 15.1531Z" fill="#011635"/>
                    <path d="M133.443 125.153C134.012 125.153 134.474 124.692 134.474 124.122C134.474 123.553 134.012 123.091 133.443 123.091C132.874 123.091 132.412 123.553 132.412 124.122C132.412 124.692 132.874 125.153 133.443 125.153Z" fill="#011635"/>
                    <path d="M68.1251 91.6491C69.6207 88.3805 72.0205 85.6083 75.041 83.6598C78.0615 81.7113 81.5766 80.668 85.171 80.653C88.7654 80.638 92.2891 81.652 95.3257 83.5752C98.3624 85.4984 100.785 88.2506 102.308 91.5065" stroke="#011635" stroke-width="2.94582" stroke-linecap="round" stroke-linejoin="round"/>
                    <g style="mix-blend-mode:soft-light" opacity="0.75">
                        <path d="M78.4243 52.2263C77.6163 48.3648 68.9191 50.2421 64.1665 55.7907C59.4139 61.3394 61.0654 65.2959 63.6318 63.5018C66.1982 61.7077 67.5765 57.8581 72.4598 56.3729C74.4796 55.8145 79.2322 55.8739 78.4243 52.2263Z" fill="#011635"/>
                    </g>
                    <g style="mix-blend-mode:soft-light" opacity="0.75">
                        <path d="M58.892 68.7772C56.5157 68.599 57.1573 64.9751 59.5336 64.9751C61.9099 64.9751 61.2327 68.9673 58.892 68.7772Z" fill="#011635"/>
                    </g>
                    <path d="M102.996 49.7906C116.826 58.9987 121.187 79.827 112.216 93.8115C103.246 107.796 82.5126 112.513 68.3618 103.792C54.2109 95.0709 49.1494 74.3971 57.6684 60.1156C66.1874 45.8341 87.3365 39.3587 102.996 49.7906Z" stroke="#011635" stroke-width="2.94582" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M99.43 46.2261C113.26 55.4343 117.621 76.2625 108.65 90.247C99.6795 104.232 78.9463 108.948 64.7955 100.227C50.6446 91.5065 45.5831 70.8327 54.1021 56.5511C62.6212 42.2696 83.7702 35.7942 99.43 46.2261Z" fill="#F2F6FF"/>
                    <g style="mix-blend-mode:multiply" opacity="0.2">
                        <path d="M108.668 90.2468C111.838 85.1686 113.46 79.2772 113.337 73.292C93.0675 92.041 66.5599 91.0429 54.4883 89.3439C56.9674 93.7768 60.517 97.5185 64.8133 100.227C78.9523 108.948 99.6974 104.231 108.668 90.2468Z" fill="#011635"/>
                    </g>
                    <path d="M73.367 65.7713C73.0952 65.1078 72.6555 64.5264 72.0911 64.0842C71.5267 63.642 70.857 63.3541 70.1477 63.2489C69.4385 63.1436 68.714 63.2247 68.0456 63.484C67.3771 63.7433 66.7875 64.172 66.3347 64.7279C65.882 65.2839 65.5816 65.9481 65.463 66.6552C65.3445 67.3624 65.4119 68.0882 65.6586 68.7615C65.9053 69.4347 66.3228 70.0322 66.8702 70.4953C67.4175 70.9585 68.0759 71.2713 68.7807 71.4031C69.4962 71.4726 70.2178 71.3641 70.8813 71.0873C71.5447 70.8105 72.1295 70.3739 72.5834 69.8165C73.0373 69.2591 73.3464 68.5981 73.4831 67.8923C73.6198 67.1865 73.5799 66.4579 73.367 65.7713Z" fill="#011635" stroke="#011635" stroke-width="2.94582" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M98.54 65.7713C98.2683 65.107 97.8285 64.5249 97.2636 64.0821C96.6988 63.6394 96.0284 63.3513 95.3184 63.2462C94.6085 63.1411 93.8834 63.2226 93.2145 63.4827C92.5456 63.7428 91.956 64.1725 91.5035 64.7296C91.051 65.2866 90.7513 65.9519 90.6339 66.6599C90.5165 67.3679 90.5854 68.0943 90.8338 68.7676C91.0822 69.4409 91.5016 70.038 92.0507 70.5001C92.5998 70.9622 93.2598 71.2734 93.9656 71.4031C94.681 71.4735 95.4026 71.3655 96.066 71.0887C96.7294 70.8119 97.3138 70.375 97.767 69.817C98.2202 69.2591 98.528 68.5975 98.6629 67.8915C98.7978 67.1854 98.7556 66.457 98.54 65.7713Z" fill="#011635" stroke="#011635" stroke-width="2.94582" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M64.5567 88.0846C66.0523 84.8161 68.4521 82.0438 71.4727 80.0954C74.4932 78.1469 78.0082 77.1035 81.6026 77.0885C85.1971 77.0736 88.7207 78.0875 91.7574 80.0108C94.794 81.934 97.2169 84.6861 98.7397 87.942" stroke="#011635" stroke-width="2.94582" stroke-linecap="round" stroke-linejoin="round"/>
                    <g style="mix-blend-mode:soft-light" opacity="0.75">
                        <path d="M74.8619 48.6621C74.054 44.8006 65.3567 46.6779 60.6041 52.2265C55.8515 57.7752 57.503 61.7317 60.0694 59.9376C62.6358 58.1435 64.0141 54.2939 68.8974 52.8087C70.9172 52.2503 75.6698 52.3097 74.8619 48.6621Z" fill="white"/>
                    </g>
                    <g style="mix-blend-mode:soft-light" opacity="0.75">
                        <path d="M55.3295 65.2127C52.9532 65.0345 53.5948 61.4106 55.9711 61.4106C58.3474 61.4106 57.6702 65.4028 55.3295 65.2127Z" fill="white"/>
                    </g>
                    <path d="M99.43 46.2261C113.26 55.4343 117.621 76.2625 108.65 90.247C99.6795 104.232 78.9463 108.948 64.7955 100.227C50.6446 91.5065 45.5831 70.8327 54.1021 56.5511C62.6212 42.2696 83.7702 35.7942 99.43 46.2261Z" stroke="#011635" stroke-width="2.94582" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M52.1798 17.2124C52.433 5.43295 37.7976 -0.457448 27.6453 4.52341C17.493 9.50426 15.2235 18.8551 19.352 25.9582C23.4805 33.0613 30.3999 29.8187 36.3873 27.2008C42.3748 24.5829 52.0141 24.8329 52.1798 17.2124Z" fill="#F3F6FF"/>
                    <path d="M74.7849 10.5621C74.7849 10.297 74.7063 10.0378 74.559 9.81728C74.4117 9.5968 74.2023 9.42497 73.9573 9.32349C73.7123 9.22202 73.4428 9.19547 73.1827 9.2472C72.9226 9.29893 72.6838 9.42662 72.4963 9.61412C72.3088 9.80161 72.1811 10.0405 72.1293 10.3006C72.0776 10.5606 72.1042 10.8302 72.2056 11.0752C72.3071 11.3201 72.4789 11.5295 72.6994 11.6769C72.9199 11.8242 73.1791 11.9028 73.4443 11.9028C73.6203 11.9028 73.7947 11.8681 73.9573 11.8007C74.12 11.7334 74.2678 11.6346 74.3923 11.5101C74.5168 11.3856 74.6155 11.2378 74.6829 11.0752C74.7503 10.9125 74.7849 10.7382 74.7849 10.5621Z" stroke="#011635" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M4.78524 60.5624C4.78524 60.2972 4.70661 60.038 4.5593 59.8175C4.41198 59.597 4.2026 59.4252 3.95762 59.3237C3.71264 59.2223 3.44308 59.1957 3.18301 59.2474C2.92294 59.2992 2.68406 59.4269 2.49656 59.6144C2.30906 59.8019 2.18137 60.0407 2.12964 60.3008C2.07791 60.5609 2.10446 60.8304 2.20594 61.0754C2.30741 61.3204 2.47925 61.5298 2.69972 61.6771C2.92019 61.8244 3.1794 61.903 3.44456 61.903C3.62062 61.903 3.79496 61.8684 3.95762 61.801C4.12028 61.7336 4.26807 61.6349 4.39257 61.5104C4.51706 61.3859 4.61581 61.2381 4.68319 61.0754C4.75056 60.9128 4.78524 60.7384 4.78524 60.5624Z" stroke="#011635" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M84.7849 140.562C84.7849 140.297 84.7063 140.038 84.559 139.817C84.4117 139.597 84.2023 139.425 83.9573 139.323C83.7123 139.222 83.4428 139.195 83.1827 139.247C82.9226 139.299 82.6838 139.427 82.4963 139.614C82.3088 139.802 82.1811 140.04 82.1293 140.301C82.0776 140.561 82.1042 140.83 82.2056 141.075C82.3071 141.32 82.4789 141.53 82.6994 141.677C82.9199 141.824 83.1791 141.903 83.4443 141.903C83.6203 141.903 83.7947 141.868 83.9573 141.801C84.12 141.733 84.2678 141.635 84.3923 141.51C84.5168 141.386 84.6155 141.238 84.6829 141.075C84.7503 140.913 84.7849 140.738 84.7849 140.562Z" stroke="#011635" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M152.365 60.5621C152.365 60.297 152.286 60.0378 152.139 59.8173C151.992 59.5968 151.782 59.425 151.537 59.3235C151.292 59.222 151.023 59.1955 150.763 59.2472C150.503 59.2989 150.264 59.4266 150.076 59.6141C149.889 59.8016 149.761 60.0405 149.709 60.3006C149.658 60.5606 149.684 60.8302 149.786 61.0752C149.887 61.3201 150.059 61.5295 150.279 61.6769C150.5 61.8242 150.759 61.9028 151.024 61.9028C151.2 61.9028 151.375 61.8681 151.537 61.8007C151.7 61.7334 151.848 61.6346 151.972 61.5101C152.097 61.3856 152.196 61.2378 152.263 61.0752C152.33 60.9125 152.365 60.7382 152.365 60.5621Z" stroke="#011635" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M6.22272 123.091L0.666392 124.877" stroke="#011635" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M160.557 94.3997L166.334 93.5691" stroke="#011635" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M116.887 8.07104L118.673 2.51472" stroke="#011635" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                <div class="title-small">[{oxmultilang ident="BASKET_EMPTY"}]</div>
            </div>
        [{/block}]
    [{/if}]
[{/block}]