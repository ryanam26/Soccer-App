json.array!(@session_plans) do |session_plan|
  json.extract! session_plan, :id
  json.url session_plan_url(session_plan, format: :json)
end
