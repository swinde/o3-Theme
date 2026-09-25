[{block name="dd_widget_header_categorylist"}]
    [{if $oxcmp_categories}]
        [{assign var="homeSelected" value="false"}]
        [{if $oViewConf->getTopActionClassName() == 'start'}]
            [{assign var="homeSelected" value="true"}]
        [{/if}]
        [{assign var="oxcmp_categories" value=$oxcmp_categories}]

        <nav>
            <ul class="nav">
                [{block name="dd_widget_header_categorylist_navbar_list"}]

                    [{if $oViewConf->getViewThemeParam('blHomeLink')}]
                        <li data-level="is-level-1" class="nav-item">
                            <a data-level="is-level-1" class="nav-link" href="[{$oViewConf->getHomeLink()}]">[{oxmultilang ident="HOME"}]</a>
                        </li>
                    [{/if}]

                    [{foreach from=$oxcmp_categories item="ocat" key="catkey" name="root"}]
                        [{if $ocat->getIsVisible()}]

                            [{* CMS *}]
                            [{foreach from=$ocat->getContentCats() item="oTopCont" name="MoreTopCms"}]
                                <li data-level="is-level-1" class="nav-item">
                                    <a data-level="is-level-1" class="nav-link" href="[{$oTopCont->getLink()}]">[{$oTopCont->oxcontents__oxtitle->value}]</a>
                                </li>
                            [{/foreach}]

                            <li data-level="is-level-1" class="nav-item[{if $ocat->getSubCats()}] nav-expand[{/if}]">
                                <a data-level="is-level-1" class="nav-link[{if $smarty.foreach.root.last}] last[{/if}]" href="[{$ocat->getLink()}]" data-title="[{$ocat->oxcategories__oxtitle->value}]">
                                    [{$ocat->oxcategories__oxtitle->value}]
                                    [{if $ocat->getSubCats()}]
                                        <span class="nav-expand-link" data-level="is-level-1" role="button" aria-label="[{$ocat->oxcategories__oxtitle->value}]"></span>
                                    [{/if}]
                                </a>

                                [{if $ocat->getSubCats()}]
                                    <ul data-level="is-level-2" class="nav-items nav-expand-content">

                                        <li class="nav-item">
                                            <a data-level-back="is-level-1" class="nav-link nav-back-link" href="javascript:;">
                                                [{$ocat->oxcategories__oxtitle->value}]
                                            </a>
                                        </li>

                                        [{foreach from=$ocat->getSubCats() item="osubcat" key="subcatkey" name="SubCat"}]
                                            [{if $osubcat->getIsVisible()}]

                                                [{* CMS *}]
                                                [{foreach from=$osubcat->getContentCats() item=ocont name=MoreCms}]
                                                    <li data-level="is-level-2" class="nav-item">
                                                        <a data-level="is-level-2" class="nav-link" href="[{$ocont->getLink()}]">[{$ocont->oxcontents__oxtitle->value}]</a>
                                                    </li>
                                                [{/foreach}]

                                                [{if $osubcat->getIsVisible()}]
                                                    <li data-level="is-level-2" class="nav-item[{if $osubcat->getSubCats()}] nav-expand[{/if}]">
                                                        <a data-level="is-level-2" class="nav-link[{if $smarty.foreach.SubCat.last}] last[{/if}]" href="[{$osubcat->getLink()}]">
                                                            [{$osubcat->oxcategories__oxtitle->value}]
                                                            [{if $osubcat->getSubCats()}]
                                                                <span class="nav-expand-link" data-level="is-level-2" role="button" aria-label="[{$osubcat->oxcategories__oxtitle->value}]"></span>
                                                            [{/if}]
                                                        </a>

                                                        [{if $osubcat->getSubCats()}]
                                                            <ul data-level="is-level-3" class="nav-items nav-expand-content">

                                                                <li class="nav-item">
                                                                    <a data-level-back="is-level-2" class="nav-link nav-back-link" href="javascript:;">
                                                                        [{$osubcat->oxcategories__oxtitle->value}]
                                                                    </a>
                                                                </li>

                                                                [{foreach from=$osubcat->getSubCats() item=osubsubcat key=subsubcatkey name=SubsubCat}]
                                                                    [{if $osubsubcat->getIsVisible() }]
                                                                        <li data-level="is-level-3" class="nav-item">
                                                                            <a data-level="is-level-3" class="nav-link[{if $smarty.foreach.SubsubCat.last}] last[{/if}]" href="[{$osubsubcat->getLink()}]">[{$osubsubcat->oxcategories__oxtitle->value}]</a>
                                                                        </li>
                                                                    [{/if}]
                                                                [{/foreach}]
                                                            </ul>
                                                        [{/if}]

                                                    </li>
                                                [{/if}]
                                            [{/if}]
                                        [{/foreach}]
                                    </ul>
                                [{/if}]
                            </li>
                        [{/if}]
                    [{/foreach}]

                [{/block}]
            </ul>
        </nav>

    [{/if}]
[{/block}]
