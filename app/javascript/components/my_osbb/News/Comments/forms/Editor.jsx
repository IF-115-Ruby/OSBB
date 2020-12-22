import React from 'react';
import { Form, Button, Input } from 'antd';
import 'antd/dist/antd.css';

const { TextArea } = Input;

export const Editor = ({ onChange, onSubmit, submitting, value, focus }) => (
  <>
    <Form.Item>
      <TextArea
        rows={4}
        onPressEnter={onSubmit}
        onChange={onChange}
        value={value}
        allowClear={true}
        maxLength={500}
        showCount={true}
        autoFocus={focus}
        placeholder="Write your comment..."
      />
    </Form.Item>
    <Form.Item>
      <Button htmlType="submit" loading={submitting} onClick={onSubmit} type="primary">
        Add Comment
      </Button>
    </Form.Item>
  </>
);
