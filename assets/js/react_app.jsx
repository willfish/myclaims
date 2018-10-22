import React from 'react';
import gql from 'graphql-tag';
import { Query } from 'react-apollo';

const GET_CLAIM = gql`
  query {
    claim {
      id
      state
    }
  }
`;

const CLAIM_CHANGES = gql`
  subscription {
    claim_changes(userId: "1") {
      id
      state
    }
  }
`;

const App = () => (
  <Query query={GET_CLAIM}>
    {({ data, loading, subscribeToMore }) => {
      if (!data) {
        return null;
      }

      if (loading) {
        return <span>Loading ...</span>;
      }

      return (
        <Messages
          messages={data.messages}
          subscribeToMore={subscribeToMore}
        />
      );
    }}
  </Query>
);

class Messages extends React.Component {
  componentDidMount() {
    this.props.subscribeToMore({
      document: MESSAGE_CREATED,
      updateQuery: (prev, { subscriptionData }) => {
        if (!subscriptionData.data) return prev;

        return {
          messages: [
            ...prev.messages,
            subscriptionData.data.messageCreated,
          ],
        };
      },
    });
  }

  render() {
    return (
      <ul>
        {this.props.messages.map(message => (
          <li key={message.id}>{message.content}</li>
        ))}
      </ul>
    );
  }
}

export default App;
