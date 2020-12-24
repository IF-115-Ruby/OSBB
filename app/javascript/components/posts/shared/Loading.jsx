import React from 'react'
import { Loader, Image, Dimmer, Segment } from 'semantic-ui-react'

const Loading = () => {
  return (
    <Segment>
      <Dimmer active inverted>
        <Loader size='big'>Loading</Loader>
      </Dimmer>
      <Image src='https://react.semantic-ui.com/images/wireframe/paragraph.png' />
    </Segment>
  )
}

export default Loading
