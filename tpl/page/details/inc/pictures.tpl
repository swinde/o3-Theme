[{oxscript include="js/libs/photoswipe.min.js" priority=8}]
[{oxscript include="js/libs/photoswipe-ui-default.min.js" priority=8}]

[{assign var="oConfig" value=$oViewConf->getConfig()}]

<div class="details__picture">

    <div class="details__picture-main[{if $oView->morePics()}] splide[{/if}]"
         [{if $oView->morePics()}]data-splide='{
                                "mediaQuery": "min",
                                "pagination" : false,
                                "rewind": true,
                                "arrows" : false,
                                "breakpoints":{
                                    "992":{
                                        "arrows": true
                                    }
                                }
                                }'
         [{/if}]
    >
        [{if $oView->morePics()}]
            <div class="splide__arrows">
                <button type="button" class="splide__arrow splide__arrow--prev">
                    <svg width="6" height="10" viewBox="0 0 6 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M5 1L1 5L5 9" stroke="#121212" stroke-width="1.4" stroke-linecap="square" stroke-linejoin="round"/>
                    </svg>
                </button>
                <button type="button" class="splide__arrow splide__arrow--next">
                    <svg width="6" height="10" viewBox="0 0 6 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M1 1L5 5L1 9" stroke="#121212" stroke-width="1.4" stroke-linecap="square" stroke-linejoin="round"/>
                    </svg>
                </button>
            </div>
            <div class="splide__track">
                <div class="splide__list">
                    [{foreach from=$oView->getIcons() key="iPicNr" item="oArtIcon" name="sMorePics"}]
                        [{assign var="sPicName" value=$oPictureProduct->getPictureFieldValue("oxpic", $iPicNr)}]
                        [{* Guard getimagesize() against an empty/unresolved path (PHP 8 ValueError). *}]
                        [{assign var="sPicPath" value=$oConfig->getMasterPicturePath("product/`$iPicNr`/`$sPicName`")}]
                        [{assign var="aPicInfo" value=""}]
                        [{if $sPicPath}][{assign var="aPicInfo" value=$sPicPath|@getimagesize}][{/if}]
                        <div class="splide__slide[{if $iPicNr == 1}] active[{/if}]">
                            <a class="details__picture-zoom-link" href="[{$oPictureProduct->getMasterZoomPictureUrl($iPicNr)}]"[{if $aPicInfo}] data-width="[{$aPicInfo.0}]" data-height="[{$aPicInfo.1}]"[{/if}]>
                                <img src="[{$oPictureProduct->getPictureUrl($iPicNr)}]" alt="[{$oPictureProduct->oxarticles__oxtitle->value|strip_tags}] [{$oPictureProduct->oxarticles__oxvarselect->value|strip_tags}]" itemprop="image" class="splide__img">
                            </a>
                        </div>
                    [{/foreach}]
                </div>
            </div>
        [{else}]
            [{assign var="sPicName" value=$oPictureProduct->oxarticles__oxpic1->value}]
            [{* Guard getimagesize() against an empty/unresolved path (PHP 8 ValueError). *}]
            [{assign var="sPicPath" value=$oConfig->getMasterPicturePath("product/1/`$sPicName`")}]
            [{assign var="aPicInfo" value=""}]
            [{if $sPicPath}][{assign var="aPicInfo" value=$sPicPath|@getimagesize}][{/if}]
            <a class="details__picture-zoom-link" href="[{$oPictureProduct->getMasterZoomPictureUrl(1)}]"[{if $aPicInfo}] data-width="[{$aPicInfo.0}]" data-height="[{$aPicInfo.1}]"[{/if}]>
                <img src="[{$oPictureProduct->getPictureUrl(1)}]" alt="[{$oPictureProduct->oxarticles__oxtitle->value|strip_tags}] [{$oPictureProduct->oxarticles__oxvarselect->value|strip_tags}]" itemprop="image">
            </a>
        [{/if}]
    </div>

    [{if $oView->morePics()}]
        <div class="details__picture-thumbnails splide" data-splide='{
                                 "mediaQuery": "min",
                                 "rewind": true,
                                 "isNavigation": true,
                                 "pagination": false,
                                 "breakpoints":{
                                    "1200":{
                                        "fixedWidth": 114,
                                        "fixedHeight": 114,
                                        "gap": 15
                                    },
                                    "992":{
                                        "arrows": false,
                                        "gap": 12
                                    },
                                    "0":{
                                        "fixedWidth": 66,
                                        "fixedHeight": 66,
                                        "gap": 5
                                    }
                                }
                                }'
        >
            <div class="splide__arrows">
                <button type="button" class="splide__arrow splide__arrow--prev">
                    <svg width="6" height="10" viewBox="0 0 6 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M5 1L1 5L5 9" stroke="#121212" stroke-width="1.4" stroke-linecap="square" stroke-linejoin="round"/>
                    </svg>
                </button>
                <button type="button" class="splide__arrow splide__arrow--next">
                    <svg width="6" height="10" viewBox="0 0 6 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M1 1L5 5L1 9" stroke="#121212" stroke-width="1.4" stroke-linecap="square" stroke-linejoin="round"/>
                    </svg>
                </button>
            </div>
            <div class="splide__track">
                <div class="splide__list">
                    [{foreach from=$oView->getIcons() key="iPicNr" item="oArtIcon" name="sMorePics"}]
                        [{math equation="a-b" a=$iPicNr b=1 assign="startFromNull"}]
                        <img class="splide__slide" [{if $smarty.foreach.sMorePics.first}][{/if}] src="[{$oPictureProduct->getIconUrl($iPicNr)}]" alt="[{$smarty.foreach.sMorePics.iteration}]">
                    [{/foreach}]
                </div>
            </div>
        </div>

        [{oxscript add="
            function initPictureSlider() {
                let main = new Splide('.details__picture-main');
                let thumbnails = new Splide('.details__picture-thumbnails');

                main.sync( thumbnails );
                main.mount();
                thumbnails.mount();
            }
            initPictureSlider();
        "}]

    [{/if}]

    [{oxscript add="
        (function() {
            var pswpEl = document.querySelector('.pswp');
            if (!pswpEl || typeof PhotoSwipe === 'undefined') return;
            var basketEl = document.getElementById('offcanvas__basket');
            var links = document.querySelectorAll('.details__picture-zoom-link');
            var items = Array.prototype.map.call(links, function(a) {
                return {
                    src: a.getAttribute('href'),
                    w: parseInt(a.getAttribute('data-width')) || 0,
                    h: parseInt(a.getAttribute('data-height')) || 0
                };
            });
            if (!items.length) return;

            var pswpActive = false;

            // Block Bootstrap from showing the basket while PhotoSwipe is active.
            // show.bs.offcanvas is cancelable per Bootstrap 5 docs.
            if (basketEl) {
                basketEl.addEventListener('show.bs.offcanvas', function(e) {
                    if (pswpActive) e.preventDefault();
                });
            }

            Array.prototype.forEach.call(links, function(link, i) {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    if (basketEl) basketEl.classList.remove('show');
                    pswpActive = true;
                    var gallery = new PhotoSwipe(pswpEl, PhotoSwipeUI_Default, items, {
                        index: i,
                        bgOpacity: 1,
                        shareEl: false,
                        fullscreenEl: false,
                        tapToClose: true
                    });
                    gallery.listen('destroy', function() {
                        setTimeout(function() { pswpActive = false; }, 400);
                    });
                    gallery.init();
                });
            });
        })();
    "}]

</div>
