const TREE_SIZE: usize = 7;

pub fn proc_1<'a>(arr: &'a [i32], output: &'a mut [i32], idx: usize, i: &mut usize) {
    if idx >= arr.len() {
        return;
    }

    output[*i] = arr[idx];
    *i += 1;

    let left_idx = 2 * idx + 1;
    let right_idx = 2 * idx + 2;

    proc_1(arr, output, left_idx, i);
    proc_1(arr, output, right_idx, i);
}

pub fn proc_2(arr: &[i32], output: &'_ mut [i32], idx: usize, i: &mut usize) {
    if idx >= arr.len() {
        return;
    }

    output[idx] = arr[*i];
    *i += 1;

    let left_idx = 2 * idx + 1;
    let right_idx = 2 * idx + 2;

    proc_2(arr, output, left_idx, i);
    proc_2(arr, output, right_idx, i);
}

fn proc_4_helper(tree: &[i32], target: i32, index: usize) -> i32 {
    if index >= tree.len() {
        return -1;
    }

    if tree[index] == target {
        let mut level = 1;
        let mut current_index = index + 1; // Adjust for 0-based index

        while current_index > 1 {
            current_index /= 2;
            level += 1;
        }

        return level;
    }

    let left_idx = 2 * index + 1;
    let right_idx = 2 * index + 2;

    let left_result = proc_4_helper(tree, target, left_idx);
    if left_result != -1 {
        return left_result;
    }

    let right_result = proc_4_helper(tree, target, right_idx);
    if right_result != -1 {
        return right_result;
    }

    -1
}

pub fn proc_4(tree: &[i32], target: i32) -> i32 {
    proc_4_helper(tree, target, 0)
}

fn proc_3_helper(tree: &[i32], target: i32, idx: usize, level: i32) -> i32 {
    if idx >= tree.len() {
        return -1;
    }

    if tree[idx] == target {
        if idx == 0 {
            return 1;
        }

        return level;
    }

    let left_idx = 2 * idx + 1;
    let right_idx = 2 * idx + 2;

    let left_result = proc_3_helper(tree, target, left_idx, level + 1);
    if left_result != -1 {
        return left_result;
    }

    let right_result = proc_3_helper(tree, target, right_idx, level + 1);
    if right_result != -1 {
        return right_result;
    }

    -1
}

pub fn proc_3(tree: &[i32], target: i32) -> i32 {
    proc_3_helper(tree, target, 0, 1)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_proc_1() {
        let mut output = [0; TREE_SIZE];
        let mut i = 0;
        proc_1(&[4, 9, 10, 10, 15, 2, 3], &mut output, 0, &mut i);
        assert_eq!(output.to_vec(), vec![4, 9, 10, 15, 10, 2, 3])
    }

    #[test]
    fn test_proc_2() {
        let mut output = [0; TREE_SIZE];
        let mut position = 0;
        proc_2(&[4, 9, 10, 15, 10, 2, 3], &mut output, 0, &mut position);
        assert_eq!(output.to_vec(), vec![4, 9, 10, 10, 15, 2, 3])
    }

    #[test]
    fn test_proc_3() {
        assert_eq!(proc_3(&[4, 9, 10, 10, 15, 2, 3], 10), 3);
    }

    #[test]
    fn test_proc_4() {
        assert_eq!(proc_4(&[4, 9, 10, 15, 10, 2, 3], 3), 3);
    }
}
