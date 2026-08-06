[{assign var="_additionalParams" value=$oView->getAdditionalParams()}]
[{assign var="listType" value=$oView->getListDisplayType()}]
[{assign var="nrCatArticles" value=$oViewConf->getNrOfCatArticles()}]

[{if $nrCatArticles && $nrCatArticles|@count > 1}]
    <div class="alist__locator-perpage dropdown">
        <button type="button" class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
            [{oxmultilang ident="PRODUCTS_PER_PAGE"}] [{$oViewConf->getArtPerPageCount()}]
        </button>
        <ul class="dropdown-menu dropdown-menu-end">
            [{foreach from=$nrCatArticles item=iItemsPerPage}]
                <li>
                    <a class="dropdown-item[{if $oViewConf->getArtPerPageCount() == $iItemsPerPage}] active[{/if}]"
                       href="[{$oView->getLink()|oxaddparams:"ldtype=$listType&amp;_artperpage=$iItemsPerPage&amp;pgNr=0&amp;$_additionalParams"}]">
                        [{$iItemsPerPage}]
                    </a>
                </li>
            [{/foreach}]
        </ul>
    </div>
[{/if}]
