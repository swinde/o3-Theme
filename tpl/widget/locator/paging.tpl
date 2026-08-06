[{block name="widget_locator_paging"}]
    [{if $pages->changePage}]
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center[{if $attributes}] offset-md-3[{/if}]">

                <li class="page-item[{if !$pages->previousPage}] disabled[{/if}]">
                    [{if $pages->previousPage}]
                        <a class="page-link" href="[{$pages->previousPage}]" aria-label="[{oxmultilang ident="PREVIOUS"}]">
                            <span aria-hidden="true">
                                <svg width="8" height="13" viewBox="0 0 8 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M6.50015 11.5L1.88477 6.5L6.50015 1.5" stroke="currentColor" stroke-width="1.5" stroke-linecap="square"/>
                                </svg>
                            </span>
                            <span class="visually-hidden">[{oxmultilang ident="PREVIOUS"}]</span>
                        </a>
                    [{else}]
                        <span class="page-link">
                            <svg width="8" height="13" viewBox="0 0 8 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M6.50015 11.5L1.88477 6.5L6.50015 1.5" stroke="rgba(17, 34, 17, 0.133333)" stroke-width="1.5" stroke-linecap="square"/>
                            </svg>
                        </span>
                    [{/if}]
                </li>

                [{assign var="i" value=1}]
                [{foreach key=iPage from=$pages->changePage item=page}]
                    [{if $iPage == $i}]
                        <li class="page-item [{if $iPage == $pages->actPage}] active[{/if}]">
                            <a href="[{$page->url}]" class="page-link">[{$iPage}]</a>
                        </li>
                        [{assign var="i" value=$i+1}]
                    [{elseif $iPage > $i}]
                        <li class="page-item disabled">
                            <span>...</span>
                        </li>
                        <li class="page-item [{if $iPage == $pages->actPage}] active[{/if}]">
                            <a href="[{$page->url}]" class="page-link">[{$iPage}]</a>
                        </li>
                        [{assign var="i" value=$iPage+1}]
                    [{elseif $iPage < $i}]
                        <li class="page-item [{if $iPage == $pages->actPage}] active[{/if}]">
                            <a href="[{$page->url}]" class="page-link">[{$iPage}]</a>
                        </li>
                        <li class="page-item disabled">
                            <span>...</span>
                        </li>
                        [{assign var="i" value=$iPage+1}]
                    [{/if}]
                [{/foreach}]

                <li class="page-item[{if !$pages->nextPage}] disabled[{/if}]">
                    [{if $pages->nextPage}]
                        <a class="page-link" href="[{$pages->nextPage}]" aria-label="[{oxmultilang ident="NEXT"}]">
                            <span aria-hidden="true">
                                <svg width="8" height="13" viewBox="0 0 8 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M1.49985 1.5L6.11523 6.5L1.49985 11.5" stroke="currentColor" stroke-width="1.5" stroke-linecap="square"/>
                                </svg>
                            </span>
                            <span class="visually-hidden">[{oxmultilang ident="NEXT"}]</span>
                        </a>
                    [{else}]
                        <span class="page-link">
                            <svg width="8" height="13" viewBox="0 0 8 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M1.49985 1.5L6.11523 6.5L1.49985 11.5" stroke="rgba(17, 34, 17, 0.133333)" stroke-width="1.5" stroke-linecap="square"/>
                            </svg>
                        </span>
                    [{/if}]
                </li>
            </ul>
        </nav>
    [{/if}]
[{/block}]