[{* EU durability-guarantee label (Reg. (EU) 2025/1960 Annex II) - per-product, issue #219. *}]
[{* Contract: caller assigns oGuaranteeArticle (and optionally sGuaranteeContext) before including. *}]
[{if $oGuaranteeArticle && method_exists($oViewConf, 'getDurabilityGuaranteeLabelsEnabled') && $oViewConf->getDurabilityGuaranteeLabelsEnabled() && method_exists($oGuaranteeArticle, 'isDurabilityGuaranteeEligible') && $oGuaranteeArticle->isDurabilityGuaranteeEligible()}]
    [{assign var="sGuaranteeLabelUrl" value=""}]
    [{if method_exists($oGuaranteeArticle, 'getDurabilityGuaranteeLabelUrl')}]
        [{assign var="sGuaranteeLabelUrl" value=$oGuaranteeArticle->getDurabilityGuaranteeLabelUrl()}]
    [{/if}]
    [{assign var="sGuaranteeNestedUrl" value=""}]
    [{if method_exists($oGuaranteeArticle, 'getDurabilityGuaranteeNestedUrl')}]
        [{assign var="sGuaranteeNestedUrl" value=$oGuaranteeArticle->getDurabilityGuaranteeNestedUrl()}]
    [{/if}]
    [{assign var="sGuaranteeConditions" value=$oGuaranteeArticle->getGuaranteeConditions()}]
    [{assign var="sGuaranteeGuarantor" value=$oGuaranteeArticle->getGuaranteeGuarantor()}]

    [{if $sGuaranteeNestedUrl && $sGuaranteeLabelUrl}]
        [{* Official nested GARAN banner expands (CSS-only) to the full label plus conditions. *}]
        <details class="o3-guarantee [{$sGuaranteeContext}]">
            <summary class="o3-guarantee__summary" title="[{oxmultilang ident="O3_GUARANTEE_LABEL_IMG_ALT"}]">
                <img src="[{$sGuaranteeNestedUrl}]" alt="[{oxmultilang ident="O3_GUARANTEE_LABEL_IMG_ALT"}]" loading="lazy" class="o3-guarantee__banner">
            </summary>
            <div class="o3-guarantee__panel">
                <a href="[{$sGuaranteeLabelUrl}]" target="_blank" rel="noopener" class="o3-guarantee__full">
                    <img src="[{$sGuaranteeLabelUrl}]" alt="[{oxmultilang ident="O3_GUARANTEE_LABEL_IMG_ALT"}]" loading="lazy" class="o3-guarantee__full-img">
                </a>
                [{if $sGuaranteeConditions}]
                    <details class="o3-guarantee__conditions">
                        <summary>[{oxmultilang ident="O3_GUARANTEE_CONDITIONS_HEADING"}]</summary>
                        <div class="o3-guarantee__conditions-body">[{$sGuaranteeConditions|escape:"html"|nl2br}]</div>
                    </details>
                [{/if}]
            </div>
        </details>
    [{elseif $sGuaranteeLabelUrl}]
        [{* Degradation: no nested banner asset, render the full label directly (small) plus conditions. *}]
        <div class="o3-guarantee o3-guarantee--static [{$sGuaranteeContext}]">
            <a href="[{$sGuaranteeLabelUrl}]" target="_blank" rel="noopener" class="o3-guarantee__full">
                <img src="[{$sGuaranteeLabelUrl}]" alt="[{oxmultilang ident="O3_GUARANTEE_LABEL_IMG_ALT"}]" loading="lazy" class="o3-guarantee__full-img">
            </a>
            [{if $sGuaranteeConditions}]
                <details class="o3-guarantee__conditions">
                    <summary>[{oxmultilang ident="O3_GUARANTEE_CONDITIONS_HEADING"}]</summary>
                    <div class="o3-guarantee__conditions-body">[{$sGuaranteeConditions|escape:"html"|nl2br}]</div>
                </details>
            [{/if}]
        </div>
    [{elseif $sGuaranteeGuarantor}]
        [{* Last-resort text fallback: eligible + guarantor known but no artwork available. *}]
        <div class="o3-guarantee o3-guarantee--fallback [{$sGuaranteeContext}]">
            <p class="o3-guarantee__fallback">
                [{oxmultilang ident="O3_GUARANTEE_LABEL_FALLBACK_DURATION" args=$oGuaranteeArticle->getGuaranteeYears()}]
                ([{oxmultilang ident="O3_GUARANTEE_LABEL_FALLBACK_GUARANTOR" args=$sGuaranteeGuarantor|escape}]).
                [{oxmultilang ident="O3_GUARANTEE_LABEL_FALLBACK_NOTE"}]
                [{oxmultilang ident="O3_GUARANTEE_LEGAL_REMINDER"}]
            </p>
        </div>
    [{/if}]
    [{assign var="sGuaranteeContext" value=""}]
[{/if}]
