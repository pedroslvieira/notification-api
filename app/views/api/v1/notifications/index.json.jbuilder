json.array! @notifications do |notification|
  json.extract! notification, :id, :date, :title, :description
end
