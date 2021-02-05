json.payments @payments do |payment|
  json.extract! payment, :id, :message
end
json.pagy @pagy
