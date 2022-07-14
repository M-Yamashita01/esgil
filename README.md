# Esgil

Esgil gem retrieves the specified message from git log between the specified branch and branch.

## Installation
Install the gem by executing:

```
gem install esgil
```

## Usage
### Command line
You can get the specified `message` between `from_branch` and `to_branch`.
```
esgil --from from_branch --to to_branch --message sample
```

### Arguments
#### from (required)
You can set the from branch name you want to get log.

#### to (required)

You can set the to branch name you want to get log.
#### message (required)

You can set the message you want.
You can also use regular expression in the message.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Esgil project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/esgil/blob/main/CODE_OF_CONDUCT.md).
