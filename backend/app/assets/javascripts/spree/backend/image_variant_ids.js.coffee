class window.ImageVariantIds

  afterConstructor: ->

  beforeConstructor: ->

  constructor: (defaultExecution = true) ->
    do @beforeConstructor
    do @defaultExecution if defaultExecution
    do @afterConstructor

  defaultExecution: ->
    do @setVariables
    do @setEvents

  setEvents: ->
    $(@variantSelect).select2
      placeholder: Spree.translations.variant_placeholder
      multiple: true
      initSelection: (element, callback) ->
        url = Spree.url(Spree.routes.variants_api,
          ids: element.val()
          token: Spree.api_key
        )
        $.getJSON url, null, (data) ->
          callback(data['variants'])
      ajax:
        url: Spree.routes.variants_api
        datatype: 'json'
        data: (term, page) ->
          {
          per_page: 50,
          page: page,
          q: {
            product_id_eq: Spree.current_product_id,
            product_name_or_sku_cont: term
          },
          token: Spree.api_key
          }
        results: (data, page) ->
          more = page < data.pages
          {
          results: data['variants'],
          more: more
          }
      formatResult: (variant) ->
        if variant.is_master
          Spree.translations.all_variants
        else
          "#{variant.sku} - #{variant.options_text}"
      formatSelection: (variant) ->
        if variant.is_master
          Spree.translations.all_variants
        else
          "#{variant.sku} - #{variant.options_text}"

  setVariables: ->
    @variantSelect = $ '#image_variant_ids'
