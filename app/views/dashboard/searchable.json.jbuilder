json.array!(@search_results) do |result|
  json.partial!("dashboard/search_result", :result => result)
end