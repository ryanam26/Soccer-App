json.array!(@session_plan_categories) do |session_plan_category|
  json.extract! session_plan_category, :id
  json.url session_plan_category_url(session_plan_category, format: :json)
end
