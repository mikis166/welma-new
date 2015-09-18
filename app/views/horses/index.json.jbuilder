json.array!(@horses) do |horse|
  json.extract! horse, :id, :height, :name, :color
  json.url horse_url(horse, format: :json)
end
