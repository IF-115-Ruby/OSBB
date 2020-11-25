import React from 'react'

export const InfoHelper = (props) => {
  return (
    <div className='user-item'>
      <span className='naming-user'>{props.name}</span>
      <span className='insert-user'>{ props.value }</span>
      </div>
  );
};
