module Api::PaginationConcern
  extend ActiveSupport::Concern
  included do
    # render関数をoverrideしてJSONの出力周りをカスタマイズする
    def render(*params)
      options = params.extract_options!
      if options[:json]
        # active_model_serializersの設定を変更
        options[:adapter] = ActiveModelSerializers::Adapter::Json
        options[:key_transform] = :camel_lower
        # ページネーションが必要な時はmetaを付ける
        options[:meta] = pagination_meta(options[:json]) if options[:json].try(:current_page) && options[:meta].nil?
      end
      params << options
      super(*params)
    end

    # kaminariから値を取ってくる
    def pagination_meta(object)
      {
        current_page: object.current_page,
        next_page: object.next_page,
        prev_page: object.prev_page,
        total_pages: object.total_pages,
        total_count: object.total_count
      }
    end
  end
end
