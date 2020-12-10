import React, { useState } from 'react';
import { Icon, Pagination } from 'semantic-ui-react';
import axios from 'axios';


export const PaginationContainer = ({ totalPages, currentPage, changeState, news_id }) => {

  const handleIcon = (style) => {
    return { content: <Icon name={`angle ${style}`} />, icon: true }
  }

  const [firstItem, setFirstItem] = useState(null)
  const [prevItem, setPrevItem] = useState(null)
  const [lastItem, setLastItem] = useState(handleIcon('double right'))
  const [nextItem, setNextItem] = useState(handleIcon('right'))

  const changeIcon = (activePage) => {
    if (activePage == totalPages) {
      setFirstItem(handleIcon('double left'))
      setPrevItem(handleIcon('left'))
      setNextItem(null)
      setLastItem(null)
    } else if (activePage == 1){
      setFirstItem(null)
      setPrevItem(null)
      setNextItem(handleIcon('right'))
      setLastItem(handleIcon('double right'))
    } else {
      setFirstItem(handleIcon('double left'))
      setPrevItem(handleIcon('left'))
      setNextItem(handleIcon('right'))
      setLastItem(handleIcon('double right'))
    }
  }

  const handlePage = (e, {activePage}) => {
    let gotopage = { activePage }
    let pagenum = gotopage.activePage
    let pagestring = pagenum.toString()

    axios.get('/api/v1/news/' + news_id + '/comments?page=' + pagestring)
    .then((response) => {changeState(response.data)})
    changeIcon(activePage)
  }
  return(
    <div className='mx-auto mt-4 d-flex justify-content-center'>
      <Pagination
        onPageChange={handlePage}
        siblingRange="6"
        defaultActivePage={currentPage}
        totalPages={totalPages}
        ellipsisItem={{ content: <Icon name='ellipsis horizontal' />, icon: true }}
        firstItem={firstItem}
        lastItem={lastItem}
        prevItem={prevItem}
        nextItem={nextItem}
      />
    </div>
  )
}
