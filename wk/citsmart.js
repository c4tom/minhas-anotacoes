/* eslint-env jquery */
/* Ignore VSCODE extension StandardJS for this file */

/* --- waitForKeyElements():  A utility function, for Greasemonkey scripts,
    that detects and handles AJAXed content.

    Usage example:

        waitForKeyElements (
            "div.comments"
            , commentCallbackFunction
        );

        //--- Page-specific function to do what we want when the node is found.
        function commentCallbackFunction (jNode) {
            jNode.text ("This comment changed by waitForKeyElements().");
        }

    IMPORTANT: This function requires your script to have loaded jQuery.
*/
function waitForKeyElements(
  selectorTxt, /* Required: The jQuery selector string that
                        specifies the desired element(s).
                    */
  actionFunction, /* Required: The code to run when elements are
                        found. It is passed a jNode to the matched
                        element.
                    */
  bWaitOnce, /* Optional: If false, will continue to scan for
                        new elements even after the first match is
                        found.
                    */
  iframeSelector /* Optional: If set, identifies the iframe to
                        search.
                    */
) {
  let targetNodes, btargetsFound

  if (typeof iframeSelector === 'undefined') { targetNodes = $(selectorTxt) } else {
    targetNodes = $(iframeSelector).contents()
      .find(selectorTxt)
  }

  if (targetNodes && targetNodes.length > 0) {
    btargetsFound = true
    /* --- Found target node(s).  Go through each and act if they
            are new.
        */
    targetNodes.each(function () {
      const jThis = $(this)
      const alreadyFound = jThis.data('alreadyFound') || false

      if (!alreadyFound) {
        // --- Call the payload function.
        const cancelFound = actionFunction(jThis)
        if (cancelFound) { btargetsFound = false } else { jThis.data('alreadyFound', true) }
      }
    })
  } else {
    btargetsFound = false
  }

  // --- Get the timer-control variable for this selector.
  const controlObj = waitForKeyElements.controlObj || {}
  const controlKey = selectorTxt.replace(/[^\w]/g, '_')
  let timeControl = controlObj[controlKey]

  // --- Now set or clear the timer as appropriate.
  if (btargetsFound && bWaitOnce && timeControl) {
    // --- The only condition where we need to clear the timer.
    clearInterval(timeControl)
    delete controlObj[controlKey]
  } else {
    // --- Set a timer, if needed.
    if (!timeControl) {
      timeControl = setInterval(function () {
        waitForKeyElements(selectorTxt,
          actionFunction,
          bWaitOnce,
          iframeSelector
        )
      },
        300
      )
      controlObj[controlKey] = timeControl
    }
  }
  waitForKeyElements.controlObj = controlObj
}

/****************************************
 *  jQuery ä¸ä¸æèåæä»¶ï¼æ¯æå¤çº§èååå¾æ æ¾ç¤ºï¼
 *  èªå®ä¹æ ·å¼å®ç°çµæ´»æ§å¶èåé£æ ¼
 *
 *  å¨ MTI è®¸å¯ä¸ï¼å¯èªç±ååãä¿®æ¹ãå¤å¶è¯¥ä»£ç ã
 *  å¯ä»¥å¨ä½ çé¡¹ç®ï¼ä¸éäºåä¸çå©æ§é¡¹ç®ï¼ä¸åè´¹
 *  ä½¿ç¨æºç 
 *
 *  @copyright jhoneleeo@gmail.com
 *  @version 1.0.0
 *  Date: 2017-3-5
 *  https://www.jqueryscript.net/menu/Custom-Right-Click-Context-Menu-Plugin-jQuery-contextMenu.html
 ****************************************/
(function ($) {
  /**
     * ä¸ºå¯¹è±¡ç»å®ä¸ä¸æèåæ¹æ³
     * @function contextMenu
     * @param {Object} data èåæ°æ®ãç±textãitemsãactionç»æçå¯¹è±¡æ°ç»
     * @param {Object} options éç½®åæ°
     */
  $.fn.contextMenu = function (data, options) {
    const $body = $('body')
    const defaults = {
      name: '', // å­ç¬¦ä¸²ãä¸ä¸æèåçåç§°ï¼ç¨ä»¥åºåä¸åçä¸ä¸æèåãå¦æç¼ºçï¼æä»¶å°èªå¨åéåç§°
      offsetX: 15, // æ°å¼ãä¸ä¸æèåå·¦ä¸è§è·ç¦»é¼ æ æ°´å¹³åç§»è·ç¦»
      offsetY: 5, // æ°å¼ãä¸ä¸æèåå·¦ä¸è§è·ç¦»é¼ æ åç´åç§»è·ç¦»
      beforeShow: $.noop, // å½æ°ãèåå³å°æ¾ç¤ºä¹åæ§è¡çåè°å½æ°
      afterShow: $.noop // å½æ°ãèåæ¾ç¤ºåæ§è¡çåè°å½æ°
    }

    const params = $.extend(defaults, options || {}); const keyMap = {}
    const idKey = 'site_cm_'; const classKey = 'site-cm-'
    var name = name || ('JCM_' + +new Date() + (Math.floor(Math.random() * 1000) + 1))
    let count = 0

    /**
         * æå»ºèåHTML
         * @param {*} mdata èåæ°æ®ï¼å¦ææ²¡æèåæ°æ®ä»¥dataæ°æ®ä¸ºå
         */
    var buildMenuHtml = function (mdata) {
      // èåæ°æ®
      const menuData = mdata || data
      const idName = idKey + (mdata ? count++ : name)
      const className = classKey + 'box'

      let $mbox = $('<div id="' + idName + '" class="' + className + '" style="position:absolute; display: none;">')

      $.each(menuData, function (index, group) {
        if (!$.isArray(group)) {
          throw TypeError()
        }
        index && $mbox.append('<div class="' + classKey + 'separ">')
        if (!group.length) {
          return
        }
        const $ul = $('<ul class="' + classKey + 'group">')
        // å¾ªç¯éåæ¯ç»èå
        $.each(group, function (innerIndex, item) {
          // éè¦æ£æµèåé¡¹ç®æ¯å¦åå«å­èå
          let key; const $li = $('<li>' + item.text + ($.isArray(item.items) && item.items.length ? buildMenuHtml(item.items) : '') + '</li>')
          $.isFunction(item.action) && (key = (name + '_' + count + '_' + index + '_' + innerIndex), keyMap[key] = item.action, $li.attr('data-key', key))
          $ul.append($li).appendTo($mbox)
        })
      })
      const html = $mbox.get(0).outerHTML
      $mbox = null
      return html
    }
    // åå»ºä¸ä¸æèå
    const createContextMenu = function () {
      let $menu = $('#' + idKey + name)
      if (!$menu.length) {
        const html = buildMenuHtml()
        $menu = $(html).appendTo($body)
        $('li', $menu).on('mouseover', function () {
          $(this).addClass('hover').children('.' + classKey + 'box').show()
        }).on('mouseout', function () {
          $(this).removeClass('hover').children('.' + classKey + 'box').hide()
        }).on('click', function () {
          const key = $(this).data('key')
          key && (keyMap[key].call(this) !== false) && $menu.hide() // è°ç¨æ§è¡å½æ°
        })
        $menu.on('contextmenu', function () {
          return false
        })
      }
      return $menu
    }

    $body.on('mousedown', function (e) {
      const jid = ('#' + idKey + name)
      !$(e.target).closest(jid).length && $(jid).hide()
    })

    return this.each(function () {
      $(this).on('contextmenu', function (e) {
        if ($.isFunction(params.beforeShow) && params.beforeShow.call(this, e) === false) {
          return
        }

        e.cancelBubble = true
        e.preventDefault()

        const $menu = createContextMenu()
        $menu.show().offset({ left: e.clientX + params.offsetX, top: e.clientY + params.offsetY })

        $.isFunction(params.afterShow) && params.afterShow.call(this, e)
      })
    })
  }
})(jQuery);

//
$.descricaoWrap = true
$.toggleWrapTextDescricao = function () {
  jQuery('.tableless-th.descricao').click(function () {
    if ($.descricaoWrap === true) {
      jQuery('.tableless-td').css('white-space', 'inherit')
      $.descricaoWrap = false
    } else if ($.descricaoWrap === false) {
      jQuery('.tableless-td').css('white-space', 'nowrap')
      $.descricaoWrap = true
    }
  })
}

setTimeout(() => {
  //= =========================
  console.log('  - Prioridade (A,M,B) | Status SLA (N,V) | via JS');
  jQuery('.badge-prioridade .ng-scope').each(function () {
    const o = jQuery(this)
    o.attr('title', o.text()).text(o.text().charAt(0))
  });
  jQuery('.tableless-th.prioridade').html("P").attr("title", "Prioridade");
  //jQuery('.tableless-th.status').html("SLA").attr("title","Status do SLA");
  jQuery('.status').each(function (i) {
    const statusSLA = jQuery(this);
    jQuery(this).prevAll('.SLA').append(statusSLA.html());
    console.log(statusSLA.text().trim());
    if (statusSLA.text().trim() == "Vencida") {
      jQuery(this).parent('.request-item').css('background-color', '#ffdacc');
    }
  });




  //= =========================
  console.log('  - Data Criação/Limite  via JS');
  jQuery('.dataLimite').each(function (i) {
    const dataLimite = jQuery(this).text().trim()
    jQuery(this).prevAll('.dataCriacao').append('<br>' + dataLimite)
  });



  //= =========================
  console.log('  - Coluna Ticket e Status');
  jQuery('.prioridade, .numero, .status, .SLA').removeClass('w100').css('padding', '0');


  console.log('  - Zebrinha');
  jQuery(".tableless-tr:odd").css('background-color', '#DFDFDF');

  //==========================
  console.log("  - Toggle Descrição");
  // Adicionar Menu
  //jQuery(".cit--header-nav").append('<li class="cit--header-nav-item" title="Toggle Wrap Descrição"><a href="#" onclick="$.toggleWrapTextDescricao()">WRAP</a></li>')


  //everything is fully loaded, don't use me if you can use DOMContentLoaded
  var data = [
    [
      {
        text: "<i class='fa'></i>Cut（ctrl+x）"
      },
      {
        text: "<i class='fa site-cm-icon'></i>Copy（ctrl+c）"
      },
      {
        text: "<i class='fa site-cm-icon'></i>Novo Ticket",
        action: () => {
          jQuery("div :contains('Registrar um Ticket/Chamado')").click()
        }
      }
    ]
  ];
  $(".ec-header").css('display', 'none').contextMenu(data, {
    name: "box"
  }).show(500, function () {
    // Animation complete.
  });

  // Kanban
  if (location.hash === '#/kanban') {
    $.ajax({
      url: '/citsmart/rest/citajax/grupo/findGroupUsers',
      type: 'POST',
      data: JSON.stringify({ object: 2032, realUrl: '/citsmart/grupo/grupo.load' }),
      headers: {
        'Content-Type': "application/json"
      },
      success: function (data) {
        // Função a ser executada em caso de sucesso
        console.dir(data)
      },
      error: function (xhr, status, error) {
        // Função a ser executada em caso de erro
      }
    });
  }
  https://hml.copel.com/site/



  //================================================================
  console.log('  - Colorizar cada Responsavel');

  function setCookie(name, value, days) {
    var expires = "";
    if (days) {
      var date = new Date();
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
      expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
  }

  function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0) === ' ') c = c.substring(1, c.length);
      if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
  }

  function colorizeResponsaveis() {
    var $responsaveis = $(".responsavel");
    var grupos = {};

    $responsaveis.each(function () {
      var title = $(this).attr("title");
      var savedColor = getCookie(title); // Recupera a cor associada ao título

      if (savedColor) {
        $(this).css("background-color", savedColor);
      }

      if (!grupos[title]) {
        grupos[title] = [];
      }

      grupos[title].push(this);
    });

    var cores = ["#efc2c2", "#00cccc", "#40ff00", "#ff4d94", "#ffad33", "#b366ff", "#99bbff", "#79d279", "#ffff4d"];

    var corIndex = 0;
    for (var title in grupos) {
      if (grupos.hasOwnProperty(title)) {
        var cor = cores[corIndex % cores.length];
        var elementos = grupos[title];

        for (var i = 0; i < elementos.length; i++) {
          var savedColor = getCookie(title + "-" + i);
          if (savedColor) {
            $(elementos[i]).css("background-color", savedColor);
          } else {
            $(elementos[i]).css("background-color", cor);
            setCookie(title + "-" + i, cor, 1); // Memoriza a cor em um cookie por 1 dia
          }
        }

        corIndex++;
      }
    }
  }

  function handleClickWithDelay(event) {
    if (event.target.classList.contains('material-icons') &&
      (event.target.textContent === 'chevron_right'
        || event.target.textContent === 'chevron_left'
        || event.target.textContent === 'last_page'
        || event.target.textContent === 'first_page')) {
      console.log('Clique detectado no elemento desejado. Aguardando 1 segundos...');
      setTimeout(colorizeResponsaveis, 1500);
    }
  }

  document.addEventListener('click', handleClickWithDelay);
  colorizeResponsaveis();

  //==========================
  $(document).ajaxComplete(function () {

    console.log(" FIM do Script CitSmart ");
  });



}, 1000);

console.log('Loaded https://gitprd.copel.nt/snippets/29/raw');
