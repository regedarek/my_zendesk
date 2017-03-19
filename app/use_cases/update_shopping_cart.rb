class UpdateShoppingCart
  def run!(current_items:, target_items:)
    item_types_to_keep = []
    target_items.each do |i|
      item_types_to_keep << i.item_type
    end

    current_items.each do |item|
      unless item_types_to_keep.include? item.item_type
        item.destroy!
      end
    end

    target_items.each do |item_to_add|
      current_item = current_items.find { |i| i.item_type == item_to_add.item_type }
      if current_item
        if current_item.class == DiscountItem
          current_item.update!(
            quantity: item_to_add.quantity,
          )
          current_item
        else
          current_item.update!(
            quantity: item_to_add.quantity,
            unit_price: item_to_add.unit_price,
            item_option_ids: item_to_add.item_option_ids,
          )
          current_item.recalculate_prices
        end
      else
        current_items << item_to_add
      end
    end
    current_items
  end
end
