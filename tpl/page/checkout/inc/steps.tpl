[{block name="checkout_steps_main"}]
    <div class="component__steps">

        [{assign var=showStepLinks value=false}]
        [{if !$oView->isLowOrderPrice() && $oxcmp_basket->getProductsCount()}]
            [{assign var=showStepLinks value=true}]
        [{/if}]

        [{block name="checkout_steps_basket"}]
        [{/block}]

        [{block name="checkout_steps_send"}]
            <div class="component__steps-step[{if $active == 2}] active[{elseif $active > 2}] passed[{/if}]">
                [{if $showStepLinks}]
                    <a href="[{oxgetseourl ident=$oViewConf->getOrderLink()}]" class="listing-point-link">
                        <div class="listing-point">01</div>
                    </a>
                    <a href="[{oxgetseourl ident=$oViewConf->getOrderLink()}]">
                        [{oxmultilang ident="O3_STEPS_SEND"}]
                    </a>
                [{else}]
                    <div class="listing-point">01</div>
                    <span>[{oxmultilang ident="O3_STEPS_SEND"}]</span>
                [{/if}]
            </div>
        [{/block}]

        [{assign var=showStepLinks value=false}]
        [{if $active != 1 && $oxcmp_user && !$oView->isLowOrderPrice() && $oxcmp_basket->getProductsCount()}]
            [{assign var=showStepLinks value=true}]
        [{/if}]

        [{block name="checkout_steps_pay"}]
            <div class="component__steps-step[{if $active == 3}] active[{elseif $active > 3}] passed[{/if}]">
                [{if $showStepLinks}]
                    <a href="[{oxgetseourl ident=$oViewConf->getPaymentLink()}]" class="listing-point-link">
                        <div class="listing-point">02</div>
                    </a>
                    <a href="[{oxgetseourl ident=$oViewConf->getPaymentLink()}]">
                        [{oxmultilang ident="O3_STEPS_PAY"}]
                    </a>
                [{else}]
                    <div class="listing-point">02</div>
                    <span>[{oxmultilang ident="O3_STEPS_PAY"}]</span>
                [{/if}]
            </div>
        [{/block}]

        [{assign var=showStepLinks value=false}]
        [{if $active != 1 && $oxcmp_user && $oxcmp_basket->getProductsCount() && $oView->getPaymentList() && !$oView->isLowOrderPrice()}]
            [{assign var=showStepLinks value=true}]
        [{/if}]

        [{block name="checkout_steps_order"}]
            <div class="component__steps-step[{if $active == 4}] active[{elseif $active > 4}] passed[{/if}]">
                [{if $showStepLinks}]
                    <a href="[{oxgetseourl ident=$oViewConf->getOrderConfirmLink()}]" class="listing-point-link">
                        <div class="listing-point">03</div>
                    </a>
                    <a href="[{oxgetseourl ident=$oViewConf->getOrderConfirmLink()}]">
                        [{oxmultilang ident="O3_STEPS_ORDER"}]
                    </a>
                [{else}]
                    <div class="listing-point">03</div>
                    <span>[{oxmultilang ident="O3_STEPS_ORDER"}]</span>
                [{/if}]
            </div>
        [{/block}]

        [{block name="checkout_steps_laststep"}]
        [{/block}]
    </div>
[{/block}]
