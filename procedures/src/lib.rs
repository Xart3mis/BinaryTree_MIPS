const TREE_SIZE: usize = 7;

pub fn proc_1<'a>(arr: &'a [i32], output: &'a mut [i32]) {
    if arr.is_empty() {
        return;
    }

    // represents stack in mips
    let mut q = vec![0];

    let mut idx = 0;
    let mut i = 0_usize;
    while i < TREE_SIZE {
        output[i] = arr[idx];

        let right_idx = 2 * idx + 2;
        let left_idx = 2 * idx + 1;

        if right_idx < arr.len() {
            q.push(right_idx); //decrement stack by 4 and add right_idx to 0($sp)
        }

        if left_idx < arr.len() {
            q.push(left_idx); //decrement stack by 4 and add right_idx to 0($sp)
        }

        idx = q.pop().unwrap();
        i += 1;
    }
}

pub fn proc_2(pre_order: &[i32]) -> Vec<i32> {
    if pre_order.is_empty() {
        return vec![];
    }

    let mut level_order = vec![0; pre_order.len()];
    let mut queue_indices = vec![0]; // Queue of indices
    let mut queue_start = vec![0]; // Queue of start indices
    let mut queue_end = vec![pre_order.len() - 1]; // Queue of end indices

    let mut index = 0;
    while !queue_indices.is_empty() {
        let start = queue_start.pop().unwrap();
        let end = queue_end.pop().unwrap();

        if start > end {
            continue;
        }

        level_order[index] = pre_order[start];
        let left_index = 2 * index + 1;
        let right_index = 2 * index + 2;

        if left_index < level_order.len() && start + 1 <= end {
            queue_indices.push(left_index);
            queue_start.push(start + 1);
            queue_end.push((start + end) / 2);
        }
        if right_index < level_order.len() && start + 1 <= end {
            queue_indices.push(right_index);
            queue_start.push((start + end) / 2 + 1);
            queue_end.push(end);
        }

        index = queue_indices.pop().unwrap();
    }

    level_order
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_proc_1() {
        let mut output = [0; TREE_SIZE];
        proc_1(&[4, 9, 10, 10, 15, 2, 3], &mut output);
        assert_eq!(output.to_vec(), vec![4, 9, 10, 15, 10, 2, 3])
    }

    #[test]
    fn test_proc_2() {
        assert_eq!(
            proc_2(&[4, 9, 10, 15, 10, 2, 3]),
            vec![4, 9, 10, 10, 15, 2, 3]
        )
    }
}
