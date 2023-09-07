module ApplicationHelper

  def model_labels
    [
      {id: 1, name: "ユーザー"},
      {id: 2, name: "投稿"},
    ]
  end

  def match_labels
    [
      {id: 1, name: "完全一致"},
      {id: 2, name: "前方一致"},
      {id: 3, name: "後方一致"},
      {id: 4, name: "部分一致"},
    ]
  end
end