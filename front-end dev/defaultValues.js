const defVals = {
    login: { body:   `{
                        "email": "peter@klaven",
                        "password": "cityslicka"
                    }`,
             method: 'POST',
             url:    '/login'},
    register: { body:   `{
                            "email": "sydney@fife",
                            "password": "pistol"
                        }`,
                method: 'POST',
                url:    '/register'},
    addUsers: { body:   `[{
                                "name": "morpheus",
                                "job": "leader"
                            },
                            {
                                "name": "neo",
                                "job": "the one"
                            },
                        ]`,
                method: 'POST',
                url:    '/users'},
    getUsers: { body:   '',
                method: 'GET',
                url:    '/users'},
    getJobs: { body:    '',
               method:  'GET',
               url:     '/unknown'},
    updateJobs: { body:   `{
                                "job": "tax"
                            }`,
                  method: 'PUT',
                  url:    '/jobs'},
  };

  export default defVals;