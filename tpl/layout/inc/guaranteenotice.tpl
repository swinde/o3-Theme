[{* EU legal-guarantee notice (Reg. (EU) 2025/1960 Annex I) - shop-global fixed artwork, issue #219. *}]
[{* Always rendered in the footer, never behind a click (see tpl/widget/footer/services.tpl). *}]
[{* The CMS snippet below is strictly supplementary and must never gate the image. *}]
[{if method_exists($oViewConf, 'getGuaranteeNoticeUrl')}]
    [{assign var="sGuaranteeNoticeUrl" value=$oViewConf->getGuaranteeNoticeUrl()}]
    [{if $sGuaranteeNoticeUrl}]
        <div class="o3-guarantee-notice">
            <a href="[{$sGuaranteeNoticeUrl}]" target="_blank" rel="noopener" class="o3-guarantee-notice__link">
                <img src="[{$sGuaranteeNoticeUrl}]" alt="[{oxmultilang ident="O3_GUARANTEE_NOTICE_IMG_ALT"}]" loading="lazy" class="o3-guarantee-notice__img">
            </a>
            [{oxifcontent ident="o3_guarantee_notice_info" object="oGuaranteeCont"}]
                <div class="o3-guarantee-notice__side">
                    <div class="o3-guarantee-notice__info">[{$oGuaranteeCont->oxcontents__oxcontent->value}]</div>
                </div>
            [{/oxifcontent}]
        </div>
    [{/if}]
[{/if}]
