import React from 'react'
import PropTypes from 'prop-types'

export const InfoHelper = ({ name, value, link }) => {
  return (
    <>
    <div className='user-item'>
      <span className='naming-user'>{ name }</span>
      <span className='insert-user'>{ value ? value : 'Unknown' } { link }</span>
    </div>
    </>
  );
}

InfoHelper.propTypes = {
  name: PropTypes.string,
  value: PropTypes.string,
  link: PropTypes.object
}
