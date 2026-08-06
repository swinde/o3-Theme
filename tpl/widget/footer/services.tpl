[{block name="footer_services"}]

    [{block name="footer_services_items"}]
        <div><a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=contact"}]">[{oxmultilang ident="CONTACT"}]</a></div>
        [{if $oViewConf->getViewThemeParam('blFooterShowHelp')}]
            <div><a href="[{$oViewConf->getHelpPageLink()}]">[{oxmultilang ident="HELP"}]</a></div>
        [{/if}]
        [{oxhasrights ident="TOBASKET"}]
            [{block name="footer_services_cart"}]
                <div>
                    <a href="[{oxgetseourl ident=$oViewConf->getBasketLink()}]">
                        [{oxmultilang ident="CART"}]
                    </a>
                    [{if $oxcmp_basket && $oxcmp_basket->getItemsCount() > 0}] ([{$oxcmp_basket->getItemsCount()}])[{/if}]
                </div>
            [{/block}]
        [{/oxhasrights}]
        <div><a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account"}]">[{oxmultilang ident="ACCOUNT"}]</a></div>
        [{if $oViewConf->getRevocationLinkVisible()}]
            [{block name="o3_footer_revocation"}]
                <div class="footer__revocation">
                    <a href="[{$oViewConf->getSelfLink()}]cl=revocation"
                       class="btn btn-primary footer__revocation-btn"
                       rel="nofollow"
                       data-testid="footer-revocation-btn">
                        [{oxmultilang ident="O3_REVOCATION_FOOTER_LINK"}]
                    </a>
                </div>
            [{/block}]
        [{/if}]
        [{block name="o3_footer_guarantee_notice"}]
            [{if method_exists($oViewConf, 'getGuaranteeNoticeUrl') && $oViewConf->getGuaranteeNoticeUrl()}]
                [{* The notice artwork must be visible without any interaction - no click-to-reveal. *}]
                <div class="footer__guarantee-rights o3-guarantee-rights">
                    <div class="o3-guarantee-rights__title">[{oxmultilang ident="O3_GUARANTEE_RIGHTS_LINK"}]</div>
                    [{include file="layout/inc/guaranteenotice.tpl"}]
                </div>
            [{/if}]
        [{/block}]
    [{/block}]

[{/block}]