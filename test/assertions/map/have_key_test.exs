defmodule Map.HaveKeyTest do
  use ExUnit.Case, async: true

  defmodule SomeSpec do
    use ESpec, async: true

    subject %{a: 1, b: 2}
    
    context "Success" do
      it do: should have_key :a
      it do: should_not have_key :c
    end

    context "Error" do
      it do: should_not have_key :a
      it do: should have_key :c
    end
  end

  setup_all do
    examples = ESpec.SuiteRunner.run_examples(SomeSpec.examples, true)
    {:ok,
      success: Enum.slice(examples, 0, 1),
      errors: Enum.slice(examples, 2, 3)}
  end

  test "Success", context do
    Enum.each(context[:success], &(assert(&1.status == :success)))
  end

  test "Errors", context do
    Enum.each(context[:errors], &(assert(&1.status == :failure)))
  end
end
