Set oOldSort = Nothing

Sub ChangeSort(oSortField, oField)
  If TypeName(oOldSort) = "HTMLSpanElement" Then
    oOldSort.className = "smallestblack"
  End If

  If oSortField Is Nothing Then
    frmSearch.Sort.value = ""
  Else
    oSortField.className = "smallestred"
    Set oOldSort = oSortField
    If oField.Name = "LocType" Then
      frmSearch.Sort.value = "Type"
    Else
      frmSearch.Sort.value = oField.Name
    End If
  End If
End Sub
