[{block name="footer_information"}]
    [{oxifcontent ident="oxsecurityinfo" object="_cont"}]
        <div><a href="[{$_cont->getLink()}]">[{$_cont->oxcontents__oxtitle->value}]</a></div>
    [{/oxifcontent}]
    [{oxifcontent ident="oxrightofwithdrawal" object="_cont"}]
        <div><a href="[{$_cont->getLink()}]">[{$_cont->oxcontents__oxtitle->value}]</a></div>
    [{/oxifcontent}]

    [{if 0}]
    [{if $oxcmp_shop->oxshops__oxtelefon->value}]
        <div itemprop="contactPoint" itemscope itemtype="https://schema.org/ContactPoint">
            <meta itemprop="contactType" content="Customer Service">
            <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M18.264 13.559L16.686 11.982c-.418-.418-.985-.653-1.576-.653s-1.158.235-1.576.653l-.789.788c-.207.207-.453.372-.723.484-.27.111-.56.169-.852.169s-.582-.058-.852-.169c-.27-.112-.516-.277-.723-.484l-2.364-2.366c-.418-.418-.653-.985-.653-1.576s.235-1.158.653-1.577l.788-.788c.418-.417.653-.984.653-1.576s-.235-1.158-.653-1.576L6.448 1.734c-.194-.23-.435-.414-.707-.541A2.003 2.003 0 0 0 4.872 1c-.3 0-.597.065-.87.192-.272.127-.513.311-.707.541C-0.847 5.849 1.109 10.601 5.25 14.743c4.14 4.141 8.89 6.1 13.012 1.972.23-.193.414-.435.541-.707.127-.272.192-.569.192-.869 0-.3-.065-.597-.192-.87-.127-.272-.311-.513-.541-.707z" stroke="#fff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <span itemprop="telephone">[{$oxcmp_shop->oxshops__oxtelefon->value}]</span>
        </div>
    [{/if}]
    [{/if}]

    [{if $oxcmp_shop->oxshops__oxinfoemail->value}]
        <div itemprop="contactPoint" itemscope itemtype="https://schema.org/ContactPoint">
            <meta itemprop="contactType" content="Customer Service">
            <svg width="21.7" height="18.6" xmlns="http://www.w3.org/2000/svg" fill="none">
                <g>
                    <path stroke-linejoin="round" stroke-linecap="round" stroke-miterlimit="10" stroke-width="1.5" stroke="#fff" d="m15.87501,17.81263l-10,0c-3,0 -5,-1.5 -5,-5l0,-6.99998c0,-3.5 2,-5 5,-5l10,0c3,0 5,1.5 5,5l0,6.99998c0,3.5 -2,5 -5,5z"/>
                    <path stroke-linejoin="round" stroke-linecap="round" stroke-miterlimit="10" stroke-width="1.5" stroke="#fff" d="m15.87501,6.31265l-3.13,2.49998c-1.03,0.82 -2.72,0.82 -3.75,0l-3.12,-2.49998"/>
                </g>
            </svg>
            <span itemprop="email">[{$oxcmp_shop->oxshops__oxinfoemail->value}]</span>
        </div>
    [{/if}]

    [{if $oxcmp_shop->oxshops__oxstreet->value && $oxcmp_shop->oxshops__oxzip->value && $oxcmp_shop->oxshops__oxcity->value}]
        <div itemprop="address" itemscope itemtype="https://schema.org/PostalAddress">
            <svg width="18.8" height="21.6" xmlns="http://www.w3.org/2000/svg" fill="none">
                <g>
                    <title>Layer 1</title>
                    <path stroke-width="1.5" stroke="#fff" d="m0.99276,7.30264c1.97,-8.66 14.79999,-8.64999 16.75999,0.01c1.15,5.07998 -2.01,9.37998 -4.78,12.03998c-2.01,1.94 -5.19,1.94 -7.20999,0c-2.76,-2.66 -5.92,-6.97 -4.77,-12.04998z"/>
                    <path stroke-linejoin="round" stroke-linecap="round" stroke-width="1.5" stroke="#fff" d="m6.62305,10.31262l1.5,1.5l4,-3.99998"/>
                </g>
            </svg>
            <span itemprop="streetAddress">[{$oxcmp_shop->oxshops__oxstreet->value}]</span>, <span itemprop="postalCode">[{$oxcmp_shop->oxshops__oxzip->value}]</span> <span itemprop="addressLocality">[{$oxcmp_shop->oxshops__oxcity->value}]</span>, <span itemprop="addressCountry">[{$oxcmp_shop->oxshops__oxcountry->value}]</span>
        </div>
    [{/if}]

[{/block}]