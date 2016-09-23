def some_method_returning_array_or_nil(flag)
  flag ? [1, 2] : nil
end

def test_multiple_assignment_in_conditional_expression
  # 配列が返ると真と判定される
  if (a, b = some_method_returning_array_or_nil(true))
    assert true
  else
    flunk 'should be true'
  end

  # nilが返ると偽と判定される
  if (a, b = some_method_returning_array_or_nil(false))
    flunk 'should be false'
  else
    assert true
  end
end
