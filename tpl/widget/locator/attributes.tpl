[{block name="widget_locator_attributes"}]
    [{if $attributes}]
        [{assign var="allActiveValue" value=$sActiveValue}]

        <form method="get" action="[{$oViewConf->getSelfActionLink()}]" name="_filterlist" class="alist__filter-form" data-js="listing:filter">
            <div class="d-none">
                [{$oViewConf->getHiddenSid()}]
                [{$oViewConf->getNavFormParams()}]
                <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
                <input type="hidden" name="tpl" value="[{$oViewConf->getActTplName()}]">
                <input type="hidden" name="oxloadid" value="[{$oViewConf->getActContentLoadId()}]">
                <input type="hidden" name="fnc" value="executefilter">
                <input type="hidden" name="fname" value="">
            </div>

            [{foreach from=$attributes item=oFilterAttr key=sAttrID name=attr}]
                [{assign var="sActiveValue" value=$oFilterAttr->getActiveValue()}]

                [{if $oFilterAttr->getValues()|@count >= $oViewConf->getViewThemeParam('blShowFiltersSearch')}]
                    [{assign var="blCutValues" value=true}]
                [{else}]
                    [{assign var="blCutValues" value=false}]
                [{/if}]

                <button type="button" class="btn" data-bs-toggle="collapse" data-bs-target="#filter[{$sAttrID}]" aria-controls="filter[{$sAttrID}]" aria-expanded="[{if $oViewConf->getViewThemeParam('blShowFilters')}]true[{else}]false[{/if}]">
                    [{$oFilterAttr->getTitle()}]
                </button>

                <div class="collapse[{if $oViewConf->getViewThemeParam('blShowFilters')}] show[{/if}]" id="filter[{$sAttrID}]">
                    <input type="hidden" name="attrfilter[[{$sAttrID}]]" value="[{$sActiveValue}]">

                    [{if $blCutValues}]
                        <input class="form-control mb-3 pe-5" type="text" placeholder="[{oxmultilang ident="SEARCH"}]" data-js="listing:filter-search">
                    [{/if}]

                    <div data-js="listing:filter-values"[{if $blCutValues}] data-value-number="[{$oViewConf->getViewThemeParam('blShowFiltersSearch')}]" style="max-height:calc([{$oViewConf->getViewThemeParam('blShowFiltersSearch')}] * 40px)"[{/if}]>
                        [{foreach from=$oFilterAttr->getValues() item=sValue name=filterValues}]
                            <div class="form-check"[{if $blCutValues}] data-js="listing:filter-item"[{/if}]>
                                <input class="form-check-input" type="checkbox" value="[{$sValue}]" id="[{$sAttrID}]i[{$smarty.foreach.filterValues.index}][{if $offcanvas}]offcanvas[{/if}]"[{if $sActiveValue == $sValue}] checked[{/if}]>
                                <label class="form-check-label" for="[{$sAttrID}]i[{$smarty.foreach.filterValues.index}][{if $offcanvas}]offcanvas[{/if}]">
                                    [{$sValue}]
                                </label>
                            </div>

                            [{if $sActiveValue}]
                                [{capture append="activeValuesClose"}]
                                    <button type="button" data-delete="attrfilter[[{$sAttrID}]]" class="btn">
                                        [{$sValue}]
                                        <svg width="10" height="11" viewBox="0 0 10 11" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M1.5 2L8.5 9M1.5 9L8.5 2" stroke="#929292" stroke-width="1.5" stroke-linecap="square"/>
                                        </svg>
                                    </button>
                                [{/capture}]
                            [{/if}]
                        [{/foreach}]
                    </div>
                    [{if $blCutValues}]
                        <button type="button" class="btn text-primary fw-bold p-0 mb-3" data-js="listing:filter-show-more" data-lang-more="[{oxmultilang ident="MORE"}]" data-lang-less="[{oxmultilang ident="O3_LESS"}]">
                            [{oxmultilang ident="MORE"}]
                            <svg width="10" height="11" viewBox="0 0 10 11" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M1.875 4.25L5 6.75L8.125 4.25" stroke="currentColor" stroke-width="1.5" stroke-linecap="square"/>
                            </svg>
                        </button>
                    [{/if}]
                </div>

                [{if $sActiveValue}]
                    [{assign var="hasActiveValue" value=$sActiveValue}]
                    [{assign var="allActiveValues" value=$allActiveValues|cat:$sActiveValue|cat:','}]
                [{/if}]
            [{/foreach}]

            <div class="alist__filter-active">
                [{foreach from=$activeValuesClose item="activeValueClose"}]
                    [{$activeValueClose}]
                [{/foreach}]
            </div>
            <button data-js="listing:filter-apply" type="submit" class="alist__filter-apply btn btn-primary btn-lg d-md-none">[{oxmultilang ident="APPLY"}]</button>
        </form>

        [{if $hasActiveValue}]
            <form method="get" action="[{$oViewConf->getSelfActionLink()}]" name="_resetFilter" id="resetFilter" class="order-first">
                [{$oViewConf->getHiddenSid()}]
                [{$oViewConf->getNavFormParams()}]
                <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
                <input type="hidden" name="fnc" value="resetFilter">

                <div class="title-small">[{oxmultilang ident="DD_LISTLOCATOR_FILTER_ATTRIBUTES"}]<span><button type="submit" class="btn">[{oxmultilang ident="DD_CATEGORY_RESET_BUTTON"}]</button></span></div>
            </form>
        [{else}]
            <div class="title-small order-first">[{oxmultilang ident="DD_LISTLOCATOR_FILTER_ATTRIBUTES"}]</div>
        [{/if}]
    [{/if}]
[{/block}]